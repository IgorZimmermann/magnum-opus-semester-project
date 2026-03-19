using ConsultationBackend.Dtos;

namespace ConsultationBackend.Interfaces.Services;

public interface IPrescriptionService
{
    void GeneratePrescription(Guid consultationId);
    void GetPrescription(Guid consultaionId);
    void EditPrescription(Guid consultationId, PrescriptionEditRequest request);
    void ApprovePrescription(Guid consultaionId);
}