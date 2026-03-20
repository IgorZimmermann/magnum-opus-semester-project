using System.Text.Json.Serialization;

namespace ConsultationBackend.Dtos;

public class LlmGenerateRequest
{
    [JsonPropertyName("model")]
    public string Model { get; set; } = "sam860/LFM2:2.6b";

    [JsonPropertyName("messages")]
    public List<LlmMessage> Messages { get; set; } = [];

    [JsonPropertyName("stream")]
    public bool Stream { get; set; } = false;
}

public class LlmMessage
{
    public string Role { get; set; } = "user";

    public string Content { get; set; } = string.Empty;
}
