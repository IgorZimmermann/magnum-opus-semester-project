using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Services;
using System.Data;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PrescriptionController : ControllerBase
{
    private readonly IPrescriptionService _prescriptionService;

    public PrescriptionController(IPrescriptionService prescriptionService)
    {
        _prescriptionService = prescriptionService;
    }

    [HttpPost("GeneratePrescription")]
    public async Task<IActionResult> GeneratePrescription(Guid consultationId)
    {
        try
        {
            var note = await _prescriptionService.GeneratePrescription(consultationId);
            return Ok(new { note });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
        catch (TimeoutException ex)
        {
            return BadRequest(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    [HttpGet("GetPrescription")]
    public IActionResult GetPrescription(Guid consultationId)
    {
        try
        {
            var note = _prescriptionService.GetPrescription(consultationId);
            return Ok(new { note });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(ex.Message);
        }
    }

    [HttpPut("EditPrescription")]
    public IActionResult EditPrescription(Guid consultationId, [FromBody] PrescriptionEditRequest request)
    {
        try
        {
            var note = _prescriptionService.EditPrescription(consultationId, request);
            return Ok(new { note });
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

    [HttpPost("ApprovePrescription")]
    public async Task<IActionResult> ApprovePrescription(Guid consultationId)
    {
        try
        {
            await _prescriptionService.ApprovePrescription(consultationId);
            return Ok();
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
}
