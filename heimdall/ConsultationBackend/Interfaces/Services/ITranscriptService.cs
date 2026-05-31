using ConsultationBackend.Dtos;
using ConsultationBackend.Models.NonRelational;

namespace ConsultationBackend.Interfaces.Services;

public interface ITranscriptService
{
    Task GenerateTranscript(Guid consultationId, IFormFile audio);

    RawTranscriptDocument? GetTranscript(Guid consultationId);

    RawTranscriptDocument EditTranscript(Guid consultationId, TranscriptEditRequest request);
}