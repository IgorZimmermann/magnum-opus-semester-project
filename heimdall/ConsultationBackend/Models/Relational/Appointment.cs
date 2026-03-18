namespace ConsultationBackend.Models.Relational;

public class Appointment
{
    public int AppointmentId { get; set; }

    public int DocId { get; set; }
    public int PatId { get; set; }

    public DateOnly AppointmentDate { get; set; }
    public TimeOnly AppointmentTime { get; set; }

    public bool EmailConfirmationSent { get; set; }
    public DateTime? EmailSentAt { get; set; }
    public DateTime CreatedAt { get; set; }

    public AppointmentStatus AppointmentStatus { get; set; }

    // optional navigation-like refs
    public Doctor? Doctor { get; set; }
    public Patient? Patient { get; set; }
}