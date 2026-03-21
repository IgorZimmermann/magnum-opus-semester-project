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
            You are a medical assistant. Below is a verbatim transcription of a doctor-patient consultation.
            Write a concise clinical summary in plain prose. Cover what the patient reported, what the doctor assessed, and any next steps or recommendations discussed.
            Do not include any headings or bullet points — write it as a single short paragraph.

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

        return sumamry;
    }

    public SummaryDocument GetSummary(Guid consultationId)
    {
        var filter = Builders<SummaryDocument>.Filter.And(Builders<SummaryDocument>.Filter.Eq(c => c.AppointmentId, consultationId));

        var docs = _mongo.Summaries.Find(filter).ToList();
        if (docs.Count == 0) throw new KeyNotFoundException("Summary not found");

        // this looks for the approved version first (if found)
        // the group should talk if another method / way is needed to find the old version
        return docs.FirstOrDefault(d => d.Status == "approved") ?? docs.First();
    }

    public SummaryDocument EditSummary(Guid consultationId, SummaryEditRequest request)
    {   
        var filter = Builders<SummaryDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var oldSummary = _mongo.Summaries.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Summary not found");    


        if (request.Output is null) throw new NoNullAllowedException("Output must not be null");

        // creates a new document of the summary
        // with the added difference of the "approved" status
        var updatedSummary = new SummaryDocument
        {
            DoctorId = oldSummary.DoctorId,
            DoctorName = oldSummary.DoctorName,
            PatientId = oldSummary.PatientId,
            PatientName = oldSummary.PatientName,
            Output = request.Output,
            Type = "summary",
            Status = "approved",
        };

        Console.WriteLine($"Editing Summary for {consultationId}");
        
        return updatedSummary;
    }

}