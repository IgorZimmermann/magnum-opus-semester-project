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
        var docAliceId     = Guid.Parse("11111111-1111-1111-1111-111111111111");
        var patJohnId      = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
        var consultationId = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");

        try
        {
            if (await _mongo.Consultations.CountDocumentsAsync(FilterDefinition<ConsultationDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                await _mongo.Consultations.InsertOneAsync(new ConsultationDocument
                {
                    ConsultationId = consultationId,
                    AppointmentId  = consultationId,
                    DoctorId       = docAliceId,
                    DoctorName     = "Dr. Alice Carter",
                    PatientId      = patJohnId,
                    PatientName    = "John Doe",
                    PatientEmail   = "john.doe@example.com",
                    Status         = "completed",
                    CreatedAt      = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            if (await _mongo.RawTranscripts.CountDocumentsAsync(FilterDefinition<RawTranscriptDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                await _mongo.RawTranscripts.InsertOneAsync(new RawTranscriptDocument
                {
                    AppointmentId = consultationId,
                    DoctorId      = docAliceId,
                    DoctorName    = "Dr. Alice Carter",
                    PatientId     = patJohnId,
                    PatientName   = "John Doe",
                    Transcription =
                        "Dr. Carter: Good morning, John. What brings you in today? " +
                        "John: Morning, Doctor. I've been feeling really unwell for about two weeks now. I have a persistent cough that won't go away, I'm running a fever most evenings — around 38.5 degrees — and I've lost about 3 kilograms without trying. I'm also exhausted all the time even when I sleep enough. " +
                        "Dr. Carter: I see. Any night sweats or chest pain? " +
                        "John: Yes, I wake up drenched most nights. No chest pain but I do get short of breath when I climb stairs. " +
                        "Dr. Carter: Based on what you're describing — the prolonged cough, fever, weight loss, night sweats, and fatigue — I want to run blood tests and a chest X-ray to rule out a respiratory infection or something more serious. In the meantime rest and stay hydrated. I'm prescribing a broad-spectrum antibiotic to start and we'll adjust once we have the results. Please avoid contact with vulnerable people until we know more.",
                    CreatedAt = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            if (await _mongo.Summaries.CountDocumentsAsync(FilterDefinition<SummaryDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                await _mongo.Summaries.InsertOneAsync(new SummaryDocument
                {
                    AppointmentId = consultationId,
                    DoctorId      = docAliceId,
                    DoctorName    = "Dr. Alice Carter",
                    PatientId     = patJohnId,
                    PatientName   = "John Doe",
                    Output        =
                        "John Doe, a 34-year-old male, presented with a two-week history of persistent productive cough, " +
                        "evening fever peaking at 38.5°C, significant unintentional weight loss of 3 kg, profuse night sweats, " +
                        "generalised fatigue, and exertional dyspnoea. Dr. Carter noted the constellation of symptoms is " +
                        "suggestive of a serious respiratory or systemic illness requiring further investigation. " +
                        "Blood tests and a chest X-ray were ordered to rule out tuberculosis, atypical pneumonia, or other pathology. " +
                        "A broad-spectrum antibiotic was prescribed empirically pending results, and the patient was advised to rest, " +
                        "maintain hydration, and avoid close contact with immunocompromised individuals.",
                    Type      = "summary",
                    Status    = "approved",
                    CreatedAt = DateTime.UtcNow
                }, new InsertOneOptions(), cancellationToken);
            }

            if (await _mongo.DoctorNotes.CountDocumentsAsync(FilterDefinition<DoctorNoteDocument>.Empty, cancellationToken: cancellationToken) == 0)
            {
                await _mongo.DoctorNotes.InsertOneAsync(new DoctorNoteDocument
                {
                    AppointmentId      = consultationId,
                    DoctorId           = docAliceId,
                    DoctorName         = "Dr. Alice Carter",
                    PatientId          = patJohnId,
                    PatientName        = "John Doe",
                    Symptoms           = "Persistent productive cough (2 weeks), evening fever (38.5°C), unintentional weight loss (3 kg), profuse night sweats, generalised fatigue, exertional dyspnoea",
                    Diagnosis          = "Suspected atypical pneumonia or pulmonary tuberculosis — pending investigations",
                    Description        = "34-year-old male presenting with a two-week history of constitutional and respiratory symptoms. Clinical picture warrants urgent chest X-ray and full blood count to exclude serious pulmonary pathology.",
                    AdvicePrescription = "1. Chest X-ray and full blood count requested urgently. 2. Amoxicillin-clavulanate 875/125 mg twice daily for 7 days (empirical). 3. Rest and increase fluid intake. 4. Avoid contact with immunocompromised individuals. 5. Return immediately if symptoms worsen or new symptoms develop.",
                    PdfUrl             = string.Empty,
                    Status             = "approved",
                    CreatedAt          = DateTime.UtcNow
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
