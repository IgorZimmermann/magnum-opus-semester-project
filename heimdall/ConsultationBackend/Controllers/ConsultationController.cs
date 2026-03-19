using Microsoft.AspNetCore.Mvc;
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
    public IActionResult StartConsultation(Guid bookingId)
    {
        _consultationService.StartConsultation(bookingId);
        return Ok("ok");
    }

    [HttpPost("UploadAudio")]
    public IActionResult UploadAudio(Guid consultationId, IFormFile audio)
    {
        _consultationService.UploadAudio(consultationId, audio);
        return Ok("ok");
    }

    [HttpGet("GetConsultation")]
    public IActionResult GetConsultation(Guid consultationId)
    {
        _consultationService.GetConsultation(consultationId);
        return Ok("ok");
    }
}

