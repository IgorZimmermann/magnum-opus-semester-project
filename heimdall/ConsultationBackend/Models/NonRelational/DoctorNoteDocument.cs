namespace ConsultationBackend.Models.NonRelational;

public class DoctorNoteDocument
{
    public string Id { get; set; } = string.Empty; 
    public int AppointmentId { get; set; }

    public int DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    public int PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;

    public string Symptoms { get; set; } = string.Empty;
    public string Diagnosis { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string AdvicePrescription { get; set; } = string.Empty;

    public string PdfUrl { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
}