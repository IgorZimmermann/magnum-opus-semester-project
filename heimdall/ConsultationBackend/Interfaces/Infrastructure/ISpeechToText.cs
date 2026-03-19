namespace ConsultationBackend.Interfaces.Infrastructure;

public interface IspeechToText
{
    Task<string> TranscribeAsync(Stream audio);
}