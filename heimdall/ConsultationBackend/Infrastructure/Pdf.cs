using System.Net.Http.Json;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Models.NonRelational;
using System.Text.Json.Serialization;

namespace ConsultationBackend.Infrastructure;

public class Pdf : IPdf
{
    private readonly HttpClient _httpClient;

    public Pdf(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<byte[]> GeneratePdfAsync(DoctorNoteDocument doctorNoteDocument)
    {
        var request = new SagaGenerateRequest
        {
            Doctor  = new SagaPerson { Name = doctorNoteDocument.DoctorName,  Id = 0 },
            Patient = new SagaPerson { Name = doctorNoteDocument.PatientName, Id = 0 },
            Diagnosis = doctorNoteDocument.Diagnosis,
            Description = doctorNoteDocument.Description,
            AdvicePrescription = doctorNoteDocument.AdvicePrescription
        };

        var response = await _httpClient.PostAsJsonAsync("/generate", request);

        response.EnsureSuccessStatusCode();

        return await response.Content.ReadAsByteArrayAsync();
    }

    private sealed class SagaGenerateRequest
    {
        [JsonPropertyName("doctor")]
        public SagaPerson Doctor { get; set; } = new();

        [JsonPropertyName("patient")]
        public SagaPerson Patient { get; set; } = new();

        [JsonPropertyName("diagnosis")]
        public string Diagnosis { get; set; } = string.Empty;

        [JsonPropertyName("description")]
        public string Description { get; set; } = string.Empty;

        [JsonPropertyName("advice_prescription")]
        public string AdvicePrescription { get; set; } = string.Empty;
    }

    private sealed class SagaPerson
    {
        [JsonPropertyName("name")]
        public string Name { get; set; } = string.Empty;

        [JsonPropertyName("id")]
        public int Id { get; set; }
    }
}
