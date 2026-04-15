namespace BookingBackend.DTO
{
    public class DoctorAvailability
    {
        public Guid DocId { get; set; }
        public string Name { get; set; } = string.Empty;
        public List<AvailabilitySlot> AvailabilitySlots { get; set; } = new();
    }

    public class AvailabilitySlot
    {
        public int DayOfTheWeek { get; set; } 
        public TimeOnly StartsFrom { get; set; }
        public TimeOnly EndsAt { get; set; }
    }
}
