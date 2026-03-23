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

    public async Task<string> GenerateAsync(string prompt)
    {
        var request = new LlmGenerateRequest
        {
            Messages = [new LlmMessage { Role = "user", Content = prompt }]
        };

        using var cts = new CancellationTokenSource(TimeSpan.FromMinutes(5));

        HttpResponseMessage response;
        try
        {
            response = await _httpClient.PostAsJsonAsync("/api/chat", request, cts.Token);
        }
        catch (TaskCanceledException)
        {
            throw new TimeoutException("LLM service did not respond within 5 minutes");
        }
        catch (HttpRequestException ex)
        {
            throw new InvalidOperationException("Failed to reach the LLM service", ex);
        }

        response.EnsureSuccessStatusCode();

        var results = await response.Content.ReadFromJsonAsync<LlmGenerateResponse>(cts.Token);

        if (string.IsNullOrWhiteSpace(results?.Message?.Content))
            throw new InvalidOperationException("LLM service returned an empty response");

        return results.Message.Content;
    }
}