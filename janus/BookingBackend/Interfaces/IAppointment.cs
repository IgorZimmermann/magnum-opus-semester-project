using BookingBackend.DTO;

namespace BookingBackend.Interfaces
{
    public interface IAppointment
    {
        Task<AppointmentDTO> SaveAppointmentAsync(CreateAppointmentDTO dto);
        Task<List<AppointmentDTO>> GetAppointmentsAsync();
    }
}
