using System.Net.Http.Json;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Dtos;
using ConsultationBackend.Models.NonRelational;

namespace ConsultationBackend.Infrastructure;

public class Pdf : IPdf
{
    private readonly HttpClient _httpClient;

    public Pdf (HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<byte[]> GeneratePdfAsync(DoctorNoteDocument doctorNoteDocument)
    {
        var request = doctorNoteDocument;

        var response = await _httpClient.PostAsJsonAsync("/generate", request);

        response.EnsureSuccessStatusCode();

        // wait for pdf response
        var pdfBytes = await response.Content.ReadAsByteArrayAsync();    

        return pdfBytes;
    }
}