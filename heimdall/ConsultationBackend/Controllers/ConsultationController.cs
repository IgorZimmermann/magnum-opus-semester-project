using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.DTOs;
using ConsultationBackend.Interfaces.Services;
using Microsoft.AspNetCore.Authorization;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ConsultationController : ControllerBase
{
    private readonly IConsultationService _consultationService;

    public ConsultationController(IConsultationService consultationService)
    {
        _consultationService = consultationService;
    }


    [HttpPost("StartConsultation")]
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

