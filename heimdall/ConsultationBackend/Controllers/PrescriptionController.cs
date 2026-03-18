
using Microsoft.AspNetCore.Mvc;

namespace ConsultationBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PrescriptionController : ControllerBase
{
    // here should go the interface

    [HttpPost("GeneratePrescription")]
    public IActionResult GeneratePrescription(Guid consultationId)
    {
        return Ok("ok");
    }

    [HttpGet("GetPrescription")]
    public IActionResult GetPrescription(Guid consultationId)
    {
        return Ok("ok");
    }

    // there should be something like PrescriptionEditRequest request / Prescription editedPrescription
    [HttpPut("EditPrescription")]
    public IActionResult EditPrescription(Guid consultationId, [FromBody] PrescriptionEditRequest request)
    {
        return Ok("ok");
    }

    [HttpPost("ApprovePrescription")]
    public IActionResult ApprovePrescription(Guid consultationId)
    {
        return Ok("ok");
    }


}

