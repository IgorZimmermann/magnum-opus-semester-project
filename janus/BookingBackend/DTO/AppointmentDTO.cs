namespace BookingBackend.DTO
{
    public class CreateAppointmentDTO
    {
        public int DocId { get; set; }
        public int PatId { get; set; }
        public DateOnly AppointmentDate { get; set; }
        public TimeOnly AppointmentTime { get; set; }
    }

    public class AppointmentDTO
    {
        public int AppointmentId { get; set; }
        public int DocId { get; set; }
        public int PatId { get; set; }
        public DateOnly AppointmentDate { get; set; }
        public TimeOnly AppointmentTime { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
