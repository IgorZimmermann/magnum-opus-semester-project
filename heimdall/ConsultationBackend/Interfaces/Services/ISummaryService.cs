using ConsultationBackend.Dtos;

namespace ConsultationBackend.Interfaces.Services;

public interface ISummaryService
{
    void GenerateSummary(Guid consultationId);

    void GetSummary(Guid consultationId);

    void EditSummary(Guid consultaitonId, SummaryEditRequest request);
}