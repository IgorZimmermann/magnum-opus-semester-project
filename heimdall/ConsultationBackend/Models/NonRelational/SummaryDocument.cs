namespace ConsultationBackend.Models.NonRelational;

public class SummaryDocument
{
    public string Id { get; set; } = string.Empty; // Mongo _id
    public int AppointmentId { get; set; }

    public int DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    public int PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;

    public string Output { get; set; } = string.Empty;
    
    // advice / prescription / summary
    public string Type { get; set; } = string.Empty;   

    // pending_review / approved
    public string Status { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
}