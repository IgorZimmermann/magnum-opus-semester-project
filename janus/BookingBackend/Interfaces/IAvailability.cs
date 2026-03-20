using BookingBackend.DTO;

namespace BookingBackend.Interfaces
{
    public interface IAvailability
    {
        Task<List<DoctorAvailability>> GetAllDoctorsAvailabilityAsync();
    }
}
