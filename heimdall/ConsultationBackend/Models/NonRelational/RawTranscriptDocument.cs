using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace ConsultationBackend.Models.NonRelational;

public class RawTranscriptDocument
{
    [BsonId]
    [BsonRepresentation(BsonType.ObjectId)]
    public string? Id { get; set; }

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid AppointmentId { get; set; }

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;

    public string Transcription { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
