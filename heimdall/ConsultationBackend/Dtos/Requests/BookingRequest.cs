namespace ConsultationBackend.DTOs;

public class BookingRequest
{
    public Guid BookingId { get; set; }

    public Guid DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    public Guid PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;
    public string PatientEmail { get; set; } = string.Empty;
}
