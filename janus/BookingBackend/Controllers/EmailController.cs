using BookingBackend.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BookingBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EmailController : ControllerBase
    {
        private readonly IEmailService _emailService;
        private readonly ILogger<EmailController> _logger;

        public EmailController(IEmailService emailService, ILogger<EmailController> logger)
        {
            _emailService = emailService;
            _logger = logger;
        }

        [HttpPost("send")]
        public async Task<IActionResult> SendEmailAsync([FromBody] EmailRequest request)
        {
            try
            {
                await _emailService.SendEmailAsync(request.To, request.Subject, request.Body, request.IsHtml);
                return Ok(new { message = "Email sent successfully" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Email send failed for {Recipient}", request.To);
                return StatusCode(500, new { error = ex.Message });
            }
        }
    }

    public class EmailRequest
    {
        public required string To { get; set; }
        public required string Subject { get; set; }
        public required string Body { get; set; }
        public bool IsHtml { get; set; } = false;
    }
}