namespace ConsultationBackend.Models.NonRelational;

public class RawTranscriptDocument
{
    public string Id { get; set; } = string.Empty; 
    public int AppointmentId { get; set; }

    public int DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    public int PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;

    public string Transcription { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}