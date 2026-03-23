using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Dtos;
using System.Net.Http.Json;
using System.Text.Json.Serialization;

namespace ConsultationBackend.Infrastructure;

public class Email : IEmail
{
    private readonly HttpClient _httpClient;

    public Email(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<bool> SendEmailAsync(EmailGenerateRequest emailGenerateRequest)
    {
        var mailpitRequest = new MailpitSendRequest
        {
            From    = new MailpitAddress { Email = emailGenerateRequest.FromEmail, Name = emailGenerateRequest.FromName },
            To      = emailGenerateRequest.ToEmails.Select(e => new MailpitAddress { Email = e }).ToList(),
            Cc      = emailGenerateRequest.CcEmails.Select(e => new MailpitAddress { Email = e }).ToList(),
            Bcc     = emailGenerateRequest.BccEmails.Select(e => new MailpitAddress { Email = e }).ToList(),
            Subject = emailGenerateRequest.Subject,
            Text    = emailGenerateRequest.Text,
            HTML    = emailGenerateRequest.HTML,
            Attachments = emailGenerateRequest.Attachments.Select(a => new MailpitAttachment
            {
                Name        = a.Filename,
                ContentType = a.ContentType,
                Content     = Convert.ToBase64String(a.ContentBytes)
            }).ToList()
        };

        var response = await _httpClient.PostAsJsonAsync("/api/v1/send", mailpitRequest);

        response.EnsureSuccessStatusCode();

        return response.IsSuccessStatusCode;
    }

    private sealed class MailpitSendRequest
    {
        [JsonPropertyName("From")]
        public MailpitAddress From { get; set; } = new();

        [JsonPropertyName("To")]
        public List<MailpitAddress> To { get; set; } = [];

        [JsonPropertyName("Cc")]
        public List<MailpitAddress> Cc { get; set; } = [];

        [JsonPropertyName("Bcc")]
        public List<MailpitAddress> Bcc { get; set; } = [];

        [JsonPropertyName("Subject")]
        public string Subject { get; set; } = string.Empty;

        [JsonPropertyName("Text")]
        public string Text { get; set; } = string.Empty;

        [JsonPropertyName("HTML")]
        public string HTML { get; set; } = string.Empty;

        [JsonPropertyName("Attachments")]
        public List<MailpitAttachment> Attachments { get; set; } = [];
    }

    private sealed class MailpitAddress
    {
        [JsonPropertyName("Email")]
        public string Email { get; set; } = string.Empty;

        [JsonPropertyName("Name")]
        public string Name { get; set; } = string.Empty;
    }

    private sealed class MailpitAttachment
    {
        [JsonPropertyName("Filename")]
        public string Name { get; set; } = string.Empty;

        [JsonPropertyName("ContentType")]
        public string ContentType { get; set; } = string.Empty;

        [JsonPropertyName("Content")]
        public string Content { get; set; } = string.Empty;
    }
}
