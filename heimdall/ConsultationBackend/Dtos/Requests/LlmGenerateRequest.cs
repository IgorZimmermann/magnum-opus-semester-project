using System.Text.Json.Serialization;

namespace ConsultationBackend.Dtos;

public class LlmGenerateRequest
{
    public string Model { get; set; } = "sam860/LFM2:2.6b";

    public List<LlmMessage> Messages { get; set; } = [];
}

public class LlmMessage
{
    public string Role { get; set; } = "user";

    public string Content { get; set; } = string.Empty;
}
