
using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TranscriptController : ControllerBase
{
    // here should go the interface

    [HttpPost("GenerateTranscript")]
    public IActionResult GenerateTranscript(Guid consultationId)
    {
        return Ok("ok");
    }

    [HttpGet("GetTranscript")]
    public IActionResult GetTranscript(Guid consultationId)
    {
        return Ok("ok");
    }

}

