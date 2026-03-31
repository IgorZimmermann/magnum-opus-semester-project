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
        private readonly IEmail _emailService;

        public AppointmentService(BookingDbContext context, IEmail emailService)
        {
            _context = context;
            _emailService = emailService;
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

            // Send confirmation email
            var patient = await _context.Patients.FindAsync(dto.PatId);
            var doctor = await _context.Doctors.FindAsync(dto.DocId);

            if (patient != null && doctor != null)
            {
                var emailRequest = new EmailGenerateRequest
                {
                    FromEmail = "noreply@booking.com",
                    FromName = "Booking System",
                    ToEmails = new List<string> { patient.Email },
                    Subject = "Appointment Confirmation",
                    Text = $"Your appointment with Dr. {doctor.Name} has been confirmed for {appointment.AppointmentDate} at {appointment.AppointmentTime}.",
                    HTML = $"<h2>Appointment Confirmation</h2><p>Your appointment with <strong>Dr. {doctor.Name}</strong> has been confirmed.</p><p><strong>Date:</strong> {appointment.AppointmentDate}</p><p><strong>Time:</strong> {appointment.AppointmentTime}</p>"
                };

                await _emailService.SendEmailAsync(emailRequest);
            }

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
