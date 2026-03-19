using ConsultationBackend.Interfaces.Services;

namespace ConsultationBackend.Services;

public class TranscriptService : ITranscriptService
{
    public void GenerateTranscript(Guid consultationId)
    {
        Console.WriteLine($"Generating transcript for: {consultationId}");
    }

    public void GetTranscript(Guid consultationId)
    {
        Console.WriteLine($"Getting transcript for: {consultationId}");
    }
}