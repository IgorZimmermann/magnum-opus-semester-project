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

        var response = await _httpClient.PostAsync("/process", content);

        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<SpeechToTextResponse>();

        return result?.Text ?? "Nothing returned";
    }
}