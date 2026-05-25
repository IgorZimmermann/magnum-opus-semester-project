using BookingBackend.DTO;
using BookingBackend.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookingBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class AvailabilityController : ControllerBase
    {
        private readonly IAvailability _availability;

        public AvailabilityController(IAvailability availability)
        {
            _availability = availability;
        }

        [HttpGet("doctors")]
        [AllowAnonymous]
        public async Task<ActionResult<List<DoctorAvailability>>> GetDoctorsAvailability()
        {
            var availability = await _availability.GetAllDoctorsAvailabilityAsync();
            return Ok(availability);
        }
    }
}