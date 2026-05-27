using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Dtos;
using ConsultationBackend.Data;
using ConsultationBackend.Interfaces.Infrastructure;
using MongoDB.Driver;
using ConsultationBackend.Models.NonRelational;
using System.Threading.Tasks;
using DnsClient.Protocol;
using System.Data;

namespace ConsultationBackend.Services;

public class SummaryService : ISummaryService
{

    private readonly MongoDbContext _mongo;
    private readonly ILLM _llm;

    public SummaryService(MongoDbContext mongo, ILLM llm)
    {
        _mongo = mongo;
        _llm = llm;
    }

    public async Task<SummaryDocument> GenerateSummary(Guid consultationId)
    {
        var filter = Builders<RawTranscriptDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var doc = _mongo.RawTranscripts.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Transcription not found");

        if (string.IsNullOrWhiteSpace(doc.Transcription))
        {
            throw new InvalidOperationException("Transcription is null");
        }

        var prompt = $$"""
            You are a medical assistant. Read the transcription of a doctor-patient consultation and write a clinical summary.

            STRICT RULES:
            - Output ONLY the clinical summary. No other text.
            - Do NOT use markdown, bullet points, numbered lists, headings, backticks, or emoji.
            - Do NOT include small talk, greetings, or anything not directly related to the medical consultation.
            - Only include clinically relevant information from the transcription.
            - If something is not mentioned in the transcription, do not include it.

            OUTPUT DEFINITION:
            - "Output": a plain text clinical summary written in flowing prose covering: (1) the symptoms or concerns the patient reported, (2) what the doctor assessed or found, and (3) any treatments, prescriptions, or next steps discussed

            Transcription:
            {{doc.Transcription}}
            """;

        string response;
        try
        {
            response = await _llm.GenerateAsync(prompt);
        }
        // this comes from LLM infrastructure and pass on the exception
        // when it pass the 5 minute timer
        catch (TimeoutException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Summary generation failed.", ex);
        }

        var summary = new SummaryDocument
        {
            AppointmentId = consultationId,
            DoctorId = doc.DoctorId,
            DoctorName = doc.DoctorName,
            PatientId = doc.PatientId,
            PatientName = doc.PatientName,
            Output = response,
            Type = "summary",
            Status = "pending_review"
        };

        _mongo.Summaries.InsertOne(summary);

        Console.WriteLine($"Generating summary for {consultationId}");

        return summary;
    }

    public SummaryDocument GetSummary(Guid consultationId)
    {
        var filter = Builders<SummaryDocument>.Filter.And(Builders<SummaryDocument>.Filter.Eq(c => c.AppointmentId, consultationId));

        var docs = _mongo.Summaries.Find(filter).ToList();
        if (docs.Count == 0) throw new KeyNotFoundException("Summary not found");

        return docs.OrderByDescending(d => d.CreatedAt).First();
    }

    public SummaryDocument EditSummary(Guid consultationId, SummaryEditRequest request)
    {   
        var filter = Builders<SummaryDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var oldSummary = _mongo.Summaries.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Summary not found");    


        if (request.Output is null) throw new NoNullAllowedException("Output must not be null");

        var update = Builders<SummaryDocument>.Update
            .Set(c => c.Output, request.Output)
            .Set(c => c.Status, "approved");

        _mongo.Summaries.UpdateOne(filter, update);

        oldSummary.Output = request.Output;
        oldSummary.Status = "approved";

        Console.WriteLine($"Editing Summary for {consultationId}");

        return oldSummary;
    }

}