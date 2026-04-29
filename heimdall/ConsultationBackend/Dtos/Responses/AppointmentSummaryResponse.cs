namespace ConsultationBackend.Dtos;

public class AppointmentSummaryResponse
{
    public Guid AppointmentId { get; set; }
    public string PatientName { get; set; } = string.Empty;
    public string PatientEmail { get; set; } = string.Empty;
    public DateOnly AppointmentDate { get; set; }
    public TimeOnly AppointmentTime { get; set; }
    public string AppointmentStatus { get; set; } = string.Empty;
}