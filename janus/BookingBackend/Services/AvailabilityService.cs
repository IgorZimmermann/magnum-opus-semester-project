using BookingBackend.Data;
using BookingBackend.DTO;
using BookingBackend.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace BookingBackend.Services.Implementations
{
    public class AvailabilityService : IAvailability
    {
        private readonly BookingDbContext _context;

        public AvailabilityService(BookingDbContext context)
        {
            _context = context;
        }

        public async Task<List<DoctorAvailability>> GetAllDoctorsAvailabilityAsync()
        {
            return await _context.Doctors
                .Include(d => d.WorksOn)
                .Select(d => new DoctorAvailability
                {
                    DocId = d.DocId,
                    Name = d.Name,
                    AvailabilitySlots = d.WorksOn
                        .Select(w => new AvailabilitySlot
                        {
                            DayOfTheWeek = w.DayOfTheWeek,
                            StartsFrom = w.StartsFrom,
                            EndsAt = w.EndsAt
                        })
                        .ToList()
                })
                .ToListAsync();
        }
    }
}
