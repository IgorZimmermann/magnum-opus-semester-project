namespace ConsultationBackend.Interfaces.Services;

public interface IConsultationService
{
    void StartConsultation(Guid boookingId);
    void UploadAudio(Guid consultationId, IFormFile audio);
    void GetConsultation(Guid consultationId);
}