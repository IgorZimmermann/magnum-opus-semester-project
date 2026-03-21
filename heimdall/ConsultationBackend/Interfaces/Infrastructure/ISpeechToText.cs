namespace ConsultationBackend.Interfaces.Infrastructure;

public interface ISpeechToText
{
    Task<string> TranscribeAsync(Stream audio);
}