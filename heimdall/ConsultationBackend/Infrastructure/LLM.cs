using System.Net.Http.Json;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Dtos;

namespace ConsultationBackend.Infrastructure;

public class LLM : ILLM
{
    private readonly HttpClient _httpClient;

    public LLM (HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<string> GenerateAsync(string promt)
    {
        var request = new LlmGenerateRequest
        {
            Prompt = promt
        };

        var response = await _httpClient.PostAsJsonAsync("/api/chat", request);

        response.EnsureSuccessStatusCode();

        var results = await response.Content.ReadFromJsonAsync<LlmGenerateResponse>();

        return results?.Output ?? "No output returned";
    }
}