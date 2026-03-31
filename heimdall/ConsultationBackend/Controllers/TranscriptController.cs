
using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.Interfaces.Services;
using Microsoft.AspNetCore.Authorization;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class TranscriptController : ControllerBase
{
    private readonly ITranscriptService _transcriptService;

    public TranscriptController (ITranscriptService transcriptService)
    {
        _transcriptService = transcriptService;
    }

    [HttpPost("GenerateTranscript")]
    [RequestSizeLimit(100_000_000)]
    public async Task<IActionResult> GenerateTranscript(Guid consultationId, IFormFile audio)
    {
        try
        {
            await _transcriptService.GenerateTranscript(consultationId, audio);
            return Ok("Transcript generated");
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (ArgumentNullException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpGet("GetTranscript")]
    public IActionResult GetTranscript(Guid consultationId)
    {   
        try
        {
            var transcript = _transcriptService.GetTranscript(consultationId);
            return Ok(new { transcript });    
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        
    }

}

