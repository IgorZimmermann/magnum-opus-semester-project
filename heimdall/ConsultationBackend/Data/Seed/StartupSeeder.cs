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
        var docAliceId      = Guid.Parse("11111111-1111-1111-1111-111111111111");
        var docBenId        = Guid.Parse("22222222-2222-2222-2222-222222222222");
        var patJohnId       = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
        var patJaneId       = Guid.Parse("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb");
        var aliceJohnApptId = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");
        var benJaneApptId   = Guid.Parse("dddddddd-dddd-dddd-dddd-dddddddddddd");

        try
        {
            await SeedConsultationAsync(aliceJohnApptId, docAliceId, "Dr. Alice Carter", patJohnId, "John Doe", "john.doe@example.com", cancellationToken);
            await SeedConsultationAsync(benJaneApptId,   docBenId,   "Dr. Ben Ortiz",   patJaneId, "Jane Smith", "jane.smith@example.com", cancellationToken);

            _logger.LogInformation("StartupSeeder: MongoDB seed ensured.");
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "StartupSeeder: MongoDB seed skipped due to error.");
        }
    }

    private async Task SeedConsultationAsync(Guid apptId, Guid doctorId, string doctorName, Guid patientId, string patientName, string patientEmail, CancellationToken ct)
    {
        var exists = await _mongo.Consultations
            .Find(Builders<ConsultationDocument>.Filter.Eq(c => c.AppointmentId, apptId))
            .AnyAsync(ct);
        if (exists) return;

        await _mongo.Consultations.InsertOneAsync(new ConsultationDocument
        {
            ConsultationId = apptId,
            AppointmentId  = apptId,
            DoctorId       = doctorId,
            DoctorName     = doctorName,
            PatientId      = patientId,
            PatientName    = patientName,
            PatientEmail   = patientEmail,
            Status         = "completed",
            CreatedAt      = DateTime.UtcNow
        }, new InsertOneOptions(), ct);
    }

    public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;
}
