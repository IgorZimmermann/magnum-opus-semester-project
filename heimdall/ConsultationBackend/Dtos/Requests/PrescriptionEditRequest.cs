namespace ConsultationBackend.Dtos;

public class PrescriptionEditRequest
{
    public string AdvicePrescription { get; set; } = string.Empty;
    public string Diagnosis { get; set; } = string.Empty;
    public string Symptoms { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
}