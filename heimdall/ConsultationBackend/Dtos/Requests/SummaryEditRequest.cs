// Dtos/SummaryEditRequest.cs
namespace ConsultationBackend.Dtos;

public class SummaryEditRequest
{
    public string Output { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
}