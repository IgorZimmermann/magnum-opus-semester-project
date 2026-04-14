using BookingBackend.DTO;
using BookingBackend.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookingBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class AppointmentController : ControllerBase
    {
        private readonly IAppointment _appointmentService;

        public AppointmentController(IAppointment appointmentService)
        {
            _appointmentService = appointmentService;
        }

        [HttpPost]
        public async Task<ActionResult<AppointmentDTO>> SaveAppointment([FromBody] CreateAppointmentDTO dto)
        {
            var result = await _appointmentService.SaveAppointmentAsync(dto);
            return CreatedAtAction(nameof(GetAppointments), result);
        }

        [HttpGet]
        public async Task<ActionResult<List<AppointmentDTO>>> GetAppointments()
        {
            var appointments = await _appointmentService.GetAppointmentsAsync();
            return Ok(appointments);
        }
    }
}
