using System.Data;
using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Services;
using DnsClient.Protocol;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class SummaryController : ControllerBase
{
    private readonly ISummaryService _summaryService;
    public SummaryController(ISummaryService summaryService)
    {
        _summaryService = summaryService;
    }

    [HttpPost("GenerateSummary")]
    public async Task<IActionResult> GenerateSummary(Guid consultationId)
    {
        try
        {
            var summary = await _summaryService.GenerateSummary(consultationId);
            return Ok(new {summary});
        }

        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
    }

    [HttpGet("GetSummary")]
    public IActionResult GetSummary(Guid consultationId)
    {
        try
        {
            var sumamry = _summaryService.GetSummary(consultationId);
            return Ok(new {sumamry});
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
    }

    [HttpPut("EditSumamry")]
    public IActionResult EditSummary(Guid consultationId, SummaryEditRequest request)
    {
        try
        {
            var sumamry = _summaryService.EditSummary(consultationId, request);
            return Ok(new {sumamry});
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (NoNullAllowedException ex)
        {
            return BadRequest(ex.Message);
        }
    }
}

