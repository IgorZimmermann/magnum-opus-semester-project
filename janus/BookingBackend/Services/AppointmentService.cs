using BookingBackend.Data;
using BookingBackend.DTO;
using BookingBackend.Interfaces;
using BookingBackend.Models;
using Microsoft.EntityFrameworkCore;

namespace BookingBackend.Services.Implementations
{
    public class AppointmentService : IAppointment
    {
        private readonly BookingDbContext _context;

        public AppointmentService(BookingDbContext context)
        {
            _context = context;
        }

        public async Task<AppointmentDTO> SaveAppointmentAsync(CreateAppointmentDTO dto)
        {
            var appointment = new Appointment
            {
                DocId = dto.DocId,
                PatId = dto.PatId,
                AppointmentDate = dto.AppointmentDate,
                AppointmentTime = dto.AppointmentTime,
                Status = AppointmentStatus.Confirmed,
                CreatedAt = DateTime.UtcNow
            };

            _context.Appointments.Add(appointment);
            await _context.SaveChangesAsync();

            return new AppointmentDTO
            {
                AppointmentId = appointment.AppointmentId,
                DocId = appointment.DocId,
                PatId = appointment.PatId,
                AppointmentDate = appointment.AppointmentDate,
                AppointmentTime = appointment.AppointmentTime,
                Status = appointment.Status.ToString(),
                CreatedAt = appointment.CreatedAt
            };
        }

        public async Task<List<AppointmentDTO>> GetAppointmentsAsync()
        {
            return await _context.Appointments
                .Select(a => new AppointmentDTO
                {
                    AppointmentId = a.AppointmentId,
                    DocId = a.DocId,
                    PatId = a.PatId,
                    AppointmentDate = a.AppointmentDate,
                    AppointmentTime = a.AppointmentTime,
                    Status = a.Status.ToString(),
                    CreatedAt = a.CreatedAt
                })
                .ToListAsync();
        }
    }
}
