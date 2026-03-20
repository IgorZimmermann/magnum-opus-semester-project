using ConsultationBackend.Dtos;
using ConsultationBackend.Models.NonRelational;

namespace ConsultationBackend.Interfaces.Services;

public interface IPrescriptionService
{
    Task<DoctorNoteDocument> GeneratePrescription(Guid consultationId);
    DoctorNoteDocument GetPrescription(Guid consultaionId);
    DoctorNoteDocument EditPrescription(Guid consultationId, PrescriptionEditRequest request);
    Task ApprovePrescription(Guid consultationId);
}