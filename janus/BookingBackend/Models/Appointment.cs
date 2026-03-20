namespace BookingBackend.Models
{
    public class Appointment
    {
        public int AppointmentId { get; set; }
        public int DocId { get; set; }
        public int PatId { get; set; }
        public DateOnly AppointmentDate { get; set; }
        public TimeOnly AppointmentTime { get; set; }
        public bool EmailConfirmationSent { get; set; } = false;
        public DateTime? EmailSentAt { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public AppointmentStatus Status { get; set; } = AppointmentStatus.Confirmed;

        // Navigation properties
        public Doctor Doctor { get; set; } = null!;
        public Patient Patient { get; set; } = null!;
    }
}
