using ConsultationBackend.Data;
using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Models.NonRelational;
using ConsultationBackend.Infrastructure;
using MongoDB.Driver;
using System.Data;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace ConsultationBackend.Services;

public class PrescriptionService : IPrescriptionService
{
    private static readonly JsonSerializerOptions JsonOptions = new() { PropertyNameCaseInsensitive = true };

    private readonly MongoDbContext _mongo;
    private readonly ILLM _llm;
    private readonly IPdf _pdf;
    private readonly IEmail _email;

    public PrescriptionService(MongoDbContext mongo, ILLM llm, IPdf pdf, IEmail email)
    {
        _mongo = mongo;
        _llm = llm;
        _pdf = pdf;
        _email = email;
    }

    public async Task<DoctorNoteDocument> GeneratePrescription(Guid consultationId)
    {
        var consultFilter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);
        var consultation = _mongo.Consultations.Find(consultFilter).FirstOrDefault()
            ?? throw new KeyNotFoundException("Consultation not found");

        var summaryFilter = Builders<SummaryDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var summaryDocs = _mongo.Summaries.Find(summaryFilter).ToList();
        if (summaryDocs.Count == 0) throw new KeyNotFoundException("Summary not found");
        var summary = summaryDocs.FirstOrDefault(d => d.Status == "approved") ?? summaryDocs.First();

        var prompt = $$"""
            You are a medical assistant. Based on the doctor-patient consultation summary below, generate a structured doctor's note.

            Return ONLY a valid JSON object with exactly these 4 fields (no extra text, no markdown):
            {
              "symptoms": "concise list of symptoms the patient reported",
              "diagnosis": "the doctor's diagnosis or most likely condition",
              "description": "brief clinical description of the case and findings",
              "advice_prescription": "all medical advice, prescriptions, or treatment recommendations given"
            }

            Consultation Summary:
            {{summary.Output}}
            """;

        string llmResponse;
        try
        {
            llmResponse = await _llm.GenerateAsync(prompt);
        }
        catch (TimeoutException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Prescription generation failed", ex);
        }

        DoctorNoteFields parsed;
        try
        {
            var json = llmResponse.Trim();
            parsed = JsonSerializer.Deserialize<DoctorNoteFields>(json, JsonOptions)
                ?? throw new InvalidOperationException("LLM returned null JSON");
        }
        catch (JsonException ex)
        {
            throw new InvalidOperationException("LLM response could not be parsed as JSON.", ex);
        }

        var note = new DoctorNoteDocument
        {
            AppointmentId = consultationId,
            DoctorId = consultation.DoctorId,
            DoctorName = consultation.DoctorName,
            PatientId = consultation.PatientId,
            PatientName = consultation.PatientName,
            Symptoms = parsed.Symptoms,
            Diagnosis = parsed.Diagnosis,
            Description = parsed.Description,
            AdvicePrescription = parsed.AdvicePrescription,
            PdfUrl = string.Empty,
            Status = "pending_review"
        };

        _mongo.DoctorNotes.InsertOne(note);

        Console.WriteLine($"Generated prescription for {consultationId}");

        return note;
    }

    private sealed class DoctorNoteFields
    {
        [JsonPropertyName("symptoms")]
        public string Symptoms { get; set; } = string.Empty;

        [JsonPropertyName("diagnosis")]
        public string Diagnosis { get; set; } = string.Empty;

        [JsonPropertyName("description")]
        public string Description { get; set; } = string.Empty;

        [JsonPropertyName("advice_prescription")]
        public string AdvicePrescription { get; set; } = string.Empty;
    }

    public DoctorNoteDocument GetPrescription (Guid consultationId)
    {
        var filter = Builders<DoctorNoteDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var docs = _mongo.DoctorNotes.Find(filter).ToList() ?? throw new KeyNotFoundException("Prescription not found");

        return docs.FirstOrDefault(d => d.Status == "approved") ?? docs.First();
    }

    public DoctorNoteDocument EditPrescription (Guid consultaionId, PrescriptionEditRequest request)
    {
        var filter = Builders<DoctorNoteDocument>.Filter.Eq(c => c.AppointmentId, consultaionId);
        var oldNote = _mongo.DoctorNotes.Find(filter).First();

        if (request.AdvicePrescription is null) throw new NoNullAllowedException("Advice prescription must not be null");
        if (request.Diagnosis is null) throw new NoNullAllowedException("Diagnosis must not be null");
        if (request.Symptoms is null) throw new NoNullAllowedException("Symptom must not be null");
        if (request.Description is null) throw new NoNullAllowedException("Description must not be null");

        var updatedPrescription = new DoctorNoteDocument
        {
            AppointmentId = oldNote.AppointmentId,
            DoctorId = oldNote.DoctorId,
            DoctorName = oldNote.DoctorName,
            PatientId = oldNote.PatientId,
            PatientName = oldNote.PatientName,
            Symptoms = request.Symptoms,
            Diagnosis = request.Diagnosis,
            Description = request.Description,
            AdvicePrescription = request.AdvicePrescription,
            Status = "approved"
        };

        return updatedPrescription;
    }

    public async Task ApprovePrescription(Guid consultationId)
    {
        var noteFilter = Builders<DoctorNoteDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var docs = _mongo.DoctorNotes.Find(noteFilter).ToList();
        if (docs.Count == 0) throw new KeyNotFoundException("Prescription not found");
        var note = docs.OrderByDescending(d => d.CreatedAt).First();

        var consultFilter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);
        var consultation = _mongo.Consultations.Find(consultFilter).FirstOrDefault()
            ?? throw new KeyNotFoundException("Consultation not found");

        // genereate pdf
        byte[] pdfBytes;
        try
        {
            pdfBytes = await _pdf.GeneratePdfAsync(note);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("PDF generation failed.", ex);
        }


        // send email request
        var emailRequest = new EmailGenerateRequest
        {
            FromEmail = "clinic@magnusOpus.com",
            FromName  = note.DoctorName,
            ToEmails  = [consultation.PatientEmail],
            Subject   = $"Your Doctor's Note — {note.CreatedAt:dd MMM yyyy}",
            Text      =
                $"Dear {note.PatientName},\n\n" +
                $"Please find attached your doctor's note from your consultation with {note.DoctorName}.\n\n" +
                $"Diagnosis: {note.Diagnosis}\n\n" +
                "If you have any questions, please contact the clinic.\n\nKind regards,\nThe Consultation Team",
            Attachments =
            [
                new EmailAttachmentRequest
                {
                    Filename     = $"doctors-note-{consultationId}.pdf",
                    ContentType  = "application/pdf",
                    ContentBytes = pdfBytes
                }
            ]
        };

        try
        {
            await _email.SendEmailAsync(emailRequest);
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Failed to send email.", ex);
        }

        var update = Builders<DoctorNoteDocument>.Update.Set(d => d.Status, "approved");
        _mongo.DoctorNotes.UpdateOne(noteFilter, update);

        Console.WriteLine($"Prescription approved and emailed to {consultation.PatientEmail} for {consultationId}");
    }
}