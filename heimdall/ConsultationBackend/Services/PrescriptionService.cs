using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Services;

namespace ConsultationBackend.Services;

public class PrescriptionService : IPrescriptionService
{
    public void GeneratePrescription(Guid consulationId)
    {
        Console.WriteLine($"Generating prescription for: {consulationId}");
    }

    public void GetPrescription (Guid consultationId)
    {
        Console.WriteLine($"Getting prescription for: {consultationId}");
    }

    public void EditPrescription (Guid consultaionId, PrescriptionEditRequest request)
    {
        Console.WriteLine($"Editing prescription for: {consultaionId}");
    }

    public void ApprovePrescription(Guid consultationId)
    {
        Console.WriteLine($"Approved prescription for: {consultationId}");
    }
}