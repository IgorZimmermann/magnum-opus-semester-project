namespace ConsultationBackend.Interfaces.Infrastructure;

public interface ILLM
{
    Task<string> GenerateAsync(string promt);
}