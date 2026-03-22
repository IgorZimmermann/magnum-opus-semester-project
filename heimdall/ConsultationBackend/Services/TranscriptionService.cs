using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Data;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Models.NonRelational;
using MongoDB.Driver;

namespace ConsultationBackend.Services;

public class TranscriptService : ITranscriptService
{
    private readonly MongoDbContext _mongo;
    private readonly IspeechToText _speechToText;

    public TranscriptService(MongoDbContext mongo, ISpeechToText speechToText)
    {
        _mongo = mongo;
        _speechToText = speechToText;
    }

    public async Task GenerateTranscript(Guid consultationId, IFormFile audio)
    {
        Console.WriteLine($"Uploaded audio for consultation: {consultationId}");
        
        var filter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);

        var consult = _mongo.Consultations.Find(filter).FirstOrDefault();

        if (consult is null)
        {
            throw new KeyNotFoundException("Consultation not found");
        } 

        if (audio is null)
        {
            throw new ArgumentNullException("Audio file cannot be nul   l");
        }

   
        if (!audio.FileName.EndsWith(".wav", StringComparison.OrdinalIgnoreCase))
        {
            throw new InvalidOperationException("Only .wav files are allowed");
        }

        using var stream = audio.OpenReadStream();


        // added timeout exception passed from speech to text infrastructure
        string transcript;
        try
        {
            transcript = await _speechToText.TranscribeAsync(stream);
        }
        catch (TimeoutException)
        {
            throw;
        }
        catch (Exception ex)
        {
            throw new InvalidOperationException("Transcription failed.", ex);
        }

        var doc = new RawTranscriptDocument
        {
            AppointmentId = consultationId,
            DoctorId = consult.DoctorId,
            DoctorName = consult.DoctorName,
            PatientId = consult.PatientId,
            PatientName = consult.PatientName,
            Transcription = transcript,
        };

        _mongo.RawTranscripts.InsertOne(doc);

        Console.WriteLine($"Audio file uploaded and transcribed with booking number: {consultationId}");
    }

    public RawTranscriptDocument GetTranscript(Guid consultationId)
    {
        var filter = Builders<RawTranscriptDocument>.Filter.Eq(c => c.AppointmentId, consultationId);
        var doc = _mongo.RawTranscripts.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Consultation not found");

        return doc;

    }
}