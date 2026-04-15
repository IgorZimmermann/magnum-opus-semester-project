namespace BookingBackend.Models
{
    public class Doctor
    {
        public Guid DocId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;

        // Navigation properties
        public ICollection<WorksOn> WorksOn { get; set; } = new List<WorksOn>();
        public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();
    }
}
