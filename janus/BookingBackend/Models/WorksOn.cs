using System.Runtime.InteropServices;

namespace BookingBackend.Models
{
    public class WorksOn
    {
        public Guid DocId { get; set; }
        public int DayOfTheWeek { get; set; } // 0 = Sunday, 6 = Saturday
        public TimeOnly StartsFrom { get; set; }
        public TimeOnly EndsAt { get; set; }

        // Navigation property
        public Doctor Doctor { get; set; } = null!;
    }
}
