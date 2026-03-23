using ConsultationBackend.Models;
using ConsultationBackend.Models.NonRelational;

namespace ConsultationBackend.Interfaces.Infrastructure;

public interface IPdf
{
    Task<byte[]> GeneratePdfAsync(DoctorNoteDocument doctorNoteDocument);
}