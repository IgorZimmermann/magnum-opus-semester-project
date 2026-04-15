namespace BookingBackend.DTO
{
    public class CreateAppointmentDTO
    {
        public Guid DocId { get; set; }
        public Guid PatId { get; set; }
        public DateOnly AppointmentDate { get; set; }
        public TimeOnly AppointmentTime { get; set; }
    }

    public class AppointmentDTO
    {
        public Guid AppointmentId { get; set; }
        public Guid DocId { get; set; }
        public Guid PatId { get; set; }
        public DateOnly AppointmentDate { get; set; }
        public TimeOnly AppointmentTime { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
