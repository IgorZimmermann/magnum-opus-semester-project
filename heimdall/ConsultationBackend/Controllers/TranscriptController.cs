
using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.Interfaces.Services;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TranscriptController : ControllerBase
{
    private readonly ITranscriptService _transcriptService;

    public TranscriptController (ITranscriptService transcriptService)
    {
        _transcriptService = transcriptService;
    }

    [HttpPost("GenerateTranscript")]
    public IActionResult GenerateTranscript(Guid consultationId)
    {
        _transcriptService.GenerateTranscript(consultationId);
        return Ok("ok");
    }

    [HttpGet("GetTranscript")]
    public IActionResult GetTranscript(Guid consultationId)
    {
        _transcriptService.GetTranscript(consultationId);
        return Ok("ok");
    }

}

