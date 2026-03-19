using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace ConsultationBackend.Models.NonRelational;

public class SummaryDocument
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

    public string Output { get; set; } = string.Empty;
    
    // advice / prescription / summary
    public string Type { get; set; } = string.Empty;   

    // pending_review / approved
    public string Status { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
