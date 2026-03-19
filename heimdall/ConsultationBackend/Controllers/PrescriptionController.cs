using Microsoft.AspNetCore.Mvc;
using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Services;

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
    public IActionResult GeneratePrescription(Guid consultationId)
    {
        _prescriptionService.GeneratePrescription(consultationId);
        return Ok("ok");
    }

    [HttpGet("GetPrescription")]
    public IActionResult GetPrescription(Guid consultationId)
    {
        _prescriptionService.GetPrescription(consultationId);
        return Ok("ok");
    }

    [HttpPut("EditPrescription")]
    public IActionResult EditPrescription(Guid consultationId, [FromBody] PrescriptionEditRequest request)
    {
        _prescriptionService.EditPrescription(consultationId, request);
        return Ok("ok");
    }

    [HttpPost("ApprovePrescription")]
    public IActionResult ApprovePrescription(Guid consultationId)
    {
        _prescriptionService.ApprovePrescription(consultationId);
        return Ok("ok");
    }


}

