using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Dtos;

namespace ConsultationBackend.Services;

public class SummaryService : ISummaryService
{
    public void GenerateSummary(Guid consultationId)
    {
        Console.WriteLine($"Generating summary for {consultationId}");
    }

    public void GetSummary(Guid consultaitonId)
    {
        Console.WriteLine($"Getting summary for {consultaitonId}");
    }

    public void EditSummary(Guid consultationId, SummaryEditRequest request)
    {
        Console.WriteLine($"Editing Summary for {consultationId}");
    }

}