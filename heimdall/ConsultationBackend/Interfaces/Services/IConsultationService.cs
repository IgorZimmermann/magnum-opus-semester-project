using ConsultationBackend.Dtos;
using ConsultationBackend.DTOs;

namespace ConsultationBackend.Interfaces.Services;

public interface IConsultationService
{
    Guid StartConsultation(BookingRequest request);
    ConsultationResponse GetConsultation(Guid consultationId);
}