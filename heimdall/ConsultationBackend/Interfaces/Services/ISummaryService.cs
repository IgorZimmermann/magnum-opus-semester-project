using ConsultationBackend.Dtos;
using ConsultationBackend.Models.NonRelational;

namespace ConsultationBackend.Interfaces.Services;

public interface ISummaryService
{
    Task<SummaryDocument> GenerateSummary(Guid consultationId);

    SummaryDocument GetSummary(Guid consultationId);

    SummaryDocument EditSummary(Guid consultaitonId, SummaryEditRequest request);
}