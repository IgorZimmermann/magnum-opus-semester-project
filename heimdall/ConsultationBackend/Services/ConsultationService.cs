using ConsultationBackend.Interfaces.Services;

namespace ConsultationBackend.Services;

public class ConsultationService : IConsultationService
{
    public void StartConsultation(Guid bookingId)
    {
        Console.WriteLine($"Starting consultation with booking number: {bookingId}");
    }

    public void UploadAudio(Guid consultationId, IFormFile audio)
    {
        Console.WriteLine($"Uploaded audio for consultation: {consultationId}");
    }

    public void GetConsultation(Guid consultationId)
    {
        Console.WriteLine($"Getting consultation for: {consultationId}");
    }
}