
using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class SummaryController : ControllerBase
{
    // here should go the interface

    [HttpPost("GenerateSummary")]
    public IActionResult GenerateSummary(Guid consultationId)
    {
        return Ok("ok");
    }

    [HttpGet("GetSummary")]
    public IActionResult GetSummary(Guid consultationId)
    {
        return Ok("ok");
    }

    // there should be something like Summary summary as well or SummaryEditRequest request 
    [HttpPut("EditSumamry")]
    public IActionResult EditSummary(Guid consultationId)
    {
        return Ok("ok");
    }
}

