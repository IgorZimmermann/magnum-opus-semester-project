using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Dtos;
using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace ConsultationBackend.Infrastructure;

public class SpeechToText : IspeechToText
{
    private readonly HttpClient _httpClient;

    public SpeechToText(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<string> TranscribeAsync(Stream audio)
    {
        var content = new MultipartFormDataContent();

        var fileContent = new StreamContent(audio);

        fileContent.Headers.ContentType = new MediaTypeHeaderValue("audio/wav");

        content.Add(fileContent, "file", "audio.wav");

        using var cts = new CancellationTokenSource(TimeSpan.FromMinutes(5));

        HttpResponseMessage response;
        try
        {
            response = await _httpClient.PostAsync("/process", content, cts.Token);
        }
        catch (TaskCanceledException)
        {
            throw new TimeoutException("Speech-to-text service did not respond within 5 minutes");
        }
        catch (HttpRequestException ex)
        {
            throw new InvalidOperationException("Failed to reach the speech-to-text service", ex);
        }

        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<SpeechToTextResponse>(cts.Token);

        if (string.IsNullOrWhiteSpace(result?.Text))
            throw new InvalidOperationException("Speech-to-text service returned an empty transcript");

        return result.Text;
    }
}