namespace ConsultationBackend.Dtos;

public class EmailAttachmentRequest
{
    public string Filename { get; set; } = string.Empty;
    public string ContentType { get; set; } = string.Empty;
    public byte[] ContentBytes { get; set; } = Array.Empty<byte>();
}