using ConsultationBackend.Data;
using ConsultationBackend.Models.NonRelational;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using MongoDB.Driver;

namespace ConsultationBackend.Data.Seed;

public class StartupSeeder : IHostedService
{
    private readonly MongoDbContext _mongo;
    private readonly ILogger<StartupSeeder> _logger;

    public StartupSeeder(MongoDbContext mongo, ILogger<StartupSeeder> logger)
    {
        _mongo = mongo;
        _logger = logger;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        try
        {
            // Seed minimal docs if empty
            if (await _mongo.Summaries.CountDocumentsAsync(FilterDefinition<SummaryDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
                var patJohnId  = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
                var appt1Id    = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");

                await _mongo.Summaries.InsertManyAsync([
                    new SummaryDocument
                    {
                        AppointmentId = appt1Id,
                        DoctorId = docAliceId,
                        DoctorName = "Dr. Alice Carter",
                        PatientId = patJohnId,
                        PatientName = "John Doe",
                        Output = "Patient advised rest and hydration.",
                        Type = "summary",
                        Status = "approved",
                        CreatedAt = DateTime.UtcNow
                    }
                ], cancellationToken: cancellationToken);
            }

            if (await _mongo.RawTranscripts.CountDocumentsAsync(FilterDefinition<RawTranscriptDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
                var patJohnId  = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
                var appt1Id    = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");

                await _mongo.RawTranscripts.InsertOneAsync(new RawTranscriptDocument
                {
                    AppointmentId = appt1Id,
                    DoctorId = docAliceId,
                    DoctorName = "Dr. Alice Carter",
                    PatientId = patJohnId,
                    PatientName = "John Doe",
                    Transcription = "Hello John, how are you feeling today?",
                    CreatedAt = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            if (await _mongo.DoctorNotes.CountDocumentsAsync(FilterDefinition<DoctorNoteDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
                var patJohnId  = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
                var appt1Id    = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");

                await _mongo.DoctorNotes.InsertOneAsync(new DoctorNoteDocument
                {
                    AppointmentId = appt1Id,
                    DoctorId = docAliceId,
                    DoctorName = "Dr. Alice Carter",
                    PatientId = patJohnId,
                    PatientName = "John Doe",
                    Symptoms = "Fatigue, mild fever",
                    Diagnosis = "Viral infection",
                    Description = "Likely a common cold",
                    AdvicePrescription = "Rest, hydration, paracetamol as needed",
                    PdfUrl = string.Empty,
                    CreatedAt = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            if (await _mongo.Consultations.CountDocumentsAsync(FilterDefinition<ConsultationDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
                var patJohnId  = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
                var appt1Id    = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");

                await _mongo.Consultations.InsertOneAsync(new ConsultationDocument
                {
                    AppointmentId = appt1Id,
                    DoctorId = docAliceId,
                    DoctorName = "Dr. Alice Carter",
                    PatientId = patJohnId,
                    PatientName = "John Doe",
                    PatientEmail = "john.doe@example.com",
                    Status = "completed",
                    CreatedAt = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            _logger.LogInformation("StartupSeeder: MongoDB seed ensured.");
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "StartupSeeder: MongoDB seed skipped due to error.");
        }
    }

    public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;
}
