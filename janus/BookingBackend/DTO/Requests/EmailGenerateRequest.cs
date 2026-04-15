namespace BookingBackend.DTO;

public class EmailGenerateRequest
{
    public string FromEmail { get; set; } = string.Empty;
    public string FromName { get; set; } = string.Empty;

    public List<string> ToEmails { get; set; } = new();
    public List<string> CcEmails { get; set; } = new();
    public List<string> BccEmails { get; set; } = new();

    public string Subject { get; set; } = string.Empty;
    public string Text { get; set; } = string.Empty;
    public string HTML { get; set; } = string.Empty;

    public List<EmailAttachmentRequest> Attachments { get; set; } = new();
}