using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.DTOs;
using ConsultationBackend.Interfaces.Services;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ConsultationController : ControllerBase
{
    private readonly IConsultationService _consultationService;

    public ConsultationController(IConsultationService consultationService)
    {
        _consultationService = consultationService;
    }


    [HttpPost("startConsultation")]
    public IActionResult StartConsultation(BookingRequest request)
    {
        try
        {
            var consultationId = _consultationService.StartConsultation(request);
            return Ok(new { consultationId });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpPost("UploadAudio")]
    public async Task<IActionResult> UploadAudio(Guid consultationId, IFormFile audio)
    {
        try
        {
            await _consultationService.UploadAudio(consultationId, audio);
            return Ok("Audio Uploaded");
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (ArgumentException ex)
        {
            return NotFound(ex.Message);
        }
        catch (InvalidDataException ex)
        {
            return NotFound(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return NotFound(ex.Message);
        }

    }

    [HttpGet("GetConsultation")]
    public IActionResult GetConsultation(Guid consultationId)
    {
        try
        {
            var consultation = _consultationService.GetConsultation(consultationId);
            return Ok(new { consultation });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
    }
}

