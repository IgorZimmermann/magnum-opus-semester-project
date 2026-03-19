namespace ConsultationBackend.Interfaces.Services;

public interface ITranscriptService
{
    void GenerateTranscript(Guid consultationId);

    void GetTranscript(Guid consultationId);
}