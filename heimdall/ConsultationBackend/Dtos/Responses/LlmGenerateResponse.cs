using System.Text.Json.Serialization;

namespace ConsultationBackend.Dtos;

public class LlmGenerateResponse
{
    public LlmMessage? Message { get; set; }
}
