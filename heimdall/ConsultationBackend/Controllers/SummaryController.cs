using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Services;
using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class SummaryController : ControllerBase
{
    private readonly ISummaryService _summaryService;
    public SummaryController(ISummaryService summaryService)
    {
        _summaryService = summaryService;
    }

    [HttpPost("GenerateSummary")]
    public IActionResult GenerateSummary(Guid consultationId)
    {
        _summaryService.GenerateSummary(consultationId);
        return Ok("ok");
    }

    [HttpGet("GetSummary")]
    public IActionResult GetSummary(Guid consultationId)
    {
        _summaryService.GetSummary(consultationId);
        return Ok("ok");
    }

    [HttpPut("EditSumamry")]
    public IActionResult EditSummary(Guid consultationId, SummaryEditRequest request)
    {
        _summaryService.EditSummary(consultationId, request);
        return Ok("ok");
    }
}

