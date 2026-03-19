using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace ConsultationBackend.Models.NonRelational;

public class ConsultationDocument
{
    [BsonId]
    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid ConsultationId { get; set; }

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid AppointmentId { get; set; }

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid DoctorId { get; set; }
    public string DoctorName { get; set; } = string.Empty;

    [BsonGuidRepresentation(GuidRepresentation.Standard)]
    public Guid PatientId { get; set; }
    public string PatientName { get; set; } = string.Empty;
    public string PatientEmail { get; set; } = string.Empty;

    // in_progress / completed
    public string Status { get; set; } = "in_progress";

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
