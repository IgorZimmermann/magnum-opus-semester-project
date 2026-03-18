
using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ConsultationController : ControllerBase
{
    // here should go the interface


    [HttpPost("startConsultation")]
    public IActionResult StartConsultation(Guid bookingId)
    {
        return Ok("ok");
    }

    [HttpPost("UploadAudio")]
    public IActionResult UploadAudio(Guid consultationId, IFormFile audio)
    {
        return Ok("ok");
    }

    [HttpGet("GetConsultation")]
    public IActionResult GetConsultation(Guid consultationId)
    {
        return Ok("ok");
    }
}

