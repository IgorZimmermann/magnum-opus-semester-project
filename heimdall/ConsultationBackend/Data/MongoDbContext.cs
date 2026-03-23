using ConsultationBackend.Models.NonRelational;
using Microsoft.Extensions.Options;
using MongoDB.Driver;

namespace ConsultationBackend.Data;

public class MongoDbContext
{
    private readonly IMongoDatabase _database;

    public MongoDbContext(IMongoClient mongoClient, IOptions<MongoDbSettings> settings)
    {
        _database = mongoClient.GetDatabase(settings.Value.DatabaseName);
    }

    public IMongoCollection<SummaryDocument> Summaries => _database.GetCollection<SummaryDocument>("summaries");

    public IMongoCollection<DoctorNoteDocument> DoctorNotes => _database.GetCollection<DoctorNoteDocument>("doctor_notes");

    public IMongoCollection<RawTranscriptDocument> RawTranscripts => _database.GetCollection<RawTranscriptDocument>("raw_transcripts");

    public IMongoCollection<ConsultationDocument> Consultations => _database.GetCollection<ConsultationDocument>("consultations");
}
