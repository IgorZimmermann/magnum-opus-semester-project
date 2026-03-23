namespace ConsultationBackend.Dtos;

public class ConsultationResponse
{
    public Guid ConsultationId { get; set; }
    public Guid AppointmentId { get; set; }
    public Guid DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;
    public Guid PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;
    public string PatientEmail { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}
