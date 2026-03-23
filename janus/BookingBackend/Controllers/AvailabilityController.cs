using BookingBackend.DTO;
using BookingBackend.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BookingBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AvailabilityController : ControllerBase
    {
        private readonly IAvailability _availability;

        public AvailabilityController(IAvailability availability)
        {
            _availability = availability;
        }

        [HttpGet("doctors")]
        public async Task<ActionResult<List<DoctorAvailability>>> GetDoctorsAvailability()
        {
            var availability = await _availability.GetAllDoctorsAvailabilityAsync();
            return Ok(availability);
        }
    }
}