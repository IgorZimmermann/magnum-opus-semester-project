using ConsultationBackend.Dtos;
using ConsultationBackend.DTOs;

namespace ConsultationBackend.Interfaces.Services;

public interface IConsultationService
{
    Guid StartConsultation(BookingRequest request);
    Task UploadAudio(Guid consultationId, IFormFile audio);
    ConsultationResponse GetConsultation(Guid consultationId);
}