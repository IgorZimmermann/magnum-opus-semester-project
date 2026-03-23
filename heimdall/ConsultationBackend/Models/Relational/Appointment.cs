namespace ConsultationBackend.Models.Relational;

public class Appointment
{
    public Guid AppointmentId { get; set; }

    public Guid DocId { get; set; }
    public Guid PatId { get; set; }

    public DateOnly AppointmentDate { get; set; }
    public TimeOnly AppointmentTime { get; set; }

    public bool EmailConfirmationSent { get; set; }
    public DateTime? EmailSentAt { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public AppointmentStatus AppointmentStatus { get; set; }

    // EF navigation properties
    public Doctor? Doctor { get; set; }
    public Patient? Patient { get; set; }
}
