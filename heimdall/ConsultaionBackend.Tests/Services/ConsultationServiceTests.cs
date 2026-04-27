using System.Data;
using ConsultationBackend.Data;
using ConsultationBackend.DTOs;
using ConsultationBackend.Dtos;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Models.NonRelational;
using ConsultationBackend.Models.Relational;
using ConsultationBackend.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Moq;

namespace ConsultaionBackend.Tests;

public class ConsultationServiceTests
{
    [Fact]
    public void StartConsultation_ReturnsConsultationId_AndStoresConsultation()
    {
        var request = TestHelpers.CreateBookingRequest();
        var context = TestHelpers.CreateAppDbContext("Consultation_Start_Success");
        context.Appointments.Add(TestHelpers.CreateAppointment(request.BookingId, AppointmentStatus.Confirmed));
        context.SaveChanges();

        var mongo = TestHelpers.CreateMongoDbContext(
            out var consultations,
            out _,
            out _,
            out _);

        ConsultationDocument? inserted = null;
        consultations
            .Setup(collection => collection.InsertOne(It.IsAny<ConsultationDocument>(), It.IsAny<InsertOneOptions>(), It.IsAny<CancellationToken>()))
            .Callback<ConsultationDocument, InsertOneOptions, CancellationToken>((document, _, _) => inserted = document);

        var service = new ConsultationService(context, mongo, Mock.Of<ISpeechToText>());

        var consultationId = service.StartConsultation(request);

        Assert.NotEqual(Guid.Empty, consultationId);
        Assert.NotNull(inserted);
        Assert.Equal(consultationId, inserted!.ConsultationId);
        Assert.Equal(request.BookingId, inserted.AppointmentId);
        Assert.Equal(request.DoctorId, inserted.DoctorId);
        Assert.Equal(request.PatientEmail, inserted.PatientEmail);
    }

    [Fact]
    public void GetConsultation_ReturnsMappedResponse_WhenDocumentExists()
    {
        var consultationId = Guid.NewGuid();
        var consultation = new ConsultationDocument
        {
            ConsultationId = consultationId,
            AppointmentId = Guid.NewGuid(),
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            PatientEmail = "viktor.orban@example.com",
            Status = "in_progress",
            CreatedAt = new DateTime(2026, 1, 2, 10, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out var consultations,
            out _,
            out _,
            out _);

        TestHelpers.SetupFindResult(consultations, consultation);

        var service = new ConsultationService(TestHelpers.CreateAppDbContext("Consultation_Get_Success"), mongo, Mock.Of<ISpeechToText>());

        var response = service.GetConsultation(consultationId);

        Assert.Equal(consultation.ConsultationId, response.ConsultationId);
        Assert.Equal(consultation.AppointmentId, response.AppointmentId);
        Assert.Equal(consultation.DoctorName, response.DoctorName);
        Assert.Equal(consultation.PatientEmail, response.PatientEmail);
        Assert.Equal(consultation.Status, response.Status);
    }
}

public class PrescriptionServiceTests
{
    [Fact]
    public async Task GeneratePrescription_ReturnsDoctorNote_AndStoresIt()
    {
        var consultationId = Guid.NewGuid();
        var consultation = new ConsultationDocument
        {
            ConsultationId = consultationId,
            AppointmentId = Guid.NewGuid(),
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            PatientEmail = "viktor.orban@example.com"
        };

        var summary = new SummaryDocument
        {
            AppointmentId = consultationId,
            DoctorId = consultation.DoctorId,
            DoctorName = consultation.DoctorName,
            PatientId = consultation.PatientId,
            PatientName = consultation.PatientName,
            Output = "Patient reports headache and fever.",
            Type = "summary",
            Status = "pending_review",
            CreatedAt = new DateTime(2026, 2, 1, 9, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out var consultations,
            out var summaries,
            out var doctorNotes,
            out _);

        TestHelpers.SetupFindResult(consultations, consultation);
        TestHelpers.SetupFindResult(summaries, summary);

        DoctorNoteDocument? inserted = null;
        doctorNotes
            .Setup(collection => collection.InsertOne(It.IsAny<DoctorNoteDocument>(), It.IsAny<InsertOneOptions>(), It.IsAny<CancellationToken>()))
            .Callback<DoctorNoteDocument, InsertOneOptions, CancellationToken>((document, _, _) => inserted = document);

        var llm = new Mock<ILLM>();
        llm.Setup(service => service.GenerateAsync(It.Is<string>(prompt => prompt.Contains(summary.Output))))
            .ReturnsAsync("{\"symptoms\":\"headache, fever\",\"diagnosis\":\"viral infection\",\"description\":\"The patient presents with a likely viral infection.\",\"advice_prescription\":\"rest, fluids\"}");

        var service = new PrescriptionService(mongo, llm.Object, Mock.Of<IPdf>(), Mock.Of<IEmail>());

        var note = await service.GeneratePrescription(consultationId);

        Assert.NotNull(inserted);
        Assert.Equal(consultationId, note.AppointmentId);
        Assert.Equal("headache, fever", note.Symptoms);
        Assert.Equal("viral infection", note.Diagnosis);
        Assert.Equal("pending_review", note.Status);
        Assert.Equal(note.AppointmentId, inserted!.AppointmentId);
        Assert.Equal(note.AdvicePrescription, inserted.AdvicePrescription);
    }

    [Fact]
    public void GetPrescription_ReturnsLatestDoctorNote()
    {
        var consultationId = Guid.NewGuid();
        var older = new DoctorNoteDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Symptoms = "cough",
            Diagnosis = "cold",
            Description = "Old note",
            AdvicePrescription = "rest",
            Status = "pending_review",
            CreatedAt = new DateTime(2026, 1, 1, 8, 0, 0, DateTimeKind.Utc)
        };

        var latest = new DoctorNoteDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Symptoms = "headache",
            Diagnosis = "migraine",
            Description = "Latest note",
            AdvicePrescription = "ibuprofen",
            Status = "approved",
            CreatedAt = new DateTime(2026, 1, 2, 8, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out _,
            out _,
            out var doctorNotes,
            out _);

        TestHelpers.SetupFindResult(doctorNotes, older, latest);

        var service = new PrescriptionService(mongo, Mock.Of<ILLM>(), Mock.Of<IPdf>(), Mock.Of<IEmail>());

        var note = service.GetPrescription(consultationId);

        Assert.Equal(latest.CreatedAt, note.CreatedAt);
        Assert.Equal(latest.Diagnosis, note.Diagnosis);
        Assert.Equal(latest.AdvicePrescription, note.AdvicePrescription);
    }
}

public class SummaryServiceTests
{
    [Fact]
    public async Task GenerateSummary_ReturnsSummary_AndStoresIt()
    {
        var consultationId = Guid.NewGuid();
        var transcript = new RawTranscriptDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Transcription = "Patient reports sore throat and fever. Doctor advises rest.",
            CreatedAt = new DateTime(2026, 2, 1, 8, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out _,
            out var summaries,
            out _,
            out var transcripts);

        TestHelpers.SetupFindResult(transcripts, transcript);

        SummaryDocument? inserted = null;
        summaries
            .Setup(collection => collection.InsertOne(It.IsAny<SummaryDocument>(), It.IsAny<InsertOneOptions>(), It.IsAny<CancellationToken>()))
            .Callback<SummaryDocument, InsertOneOptions, CancellationToken>((document, _, _) => inserted = document);

        var llm = new Mock<ILLM>();
        llm.Setup(service => service.GenerateAsync(It.Is<string>(prompt => prompt.Contains(transcript.Transcription))))
            .ReturnsAsync("Clinical summary for the visit.");

        var service = new SummaryService(mongo, llm.Object);

        var summary = await service.GenerateSummary(consultationId);

        Assert.NotNull(inserted);
        Assert.Equal(consultationId, summary.AppointmentId);
        Assert.Equal("Clinical summary for the visit.", summary.Output);
        Assert.Equal("pending_review", summary.Status);
        Assert.Equal(summary.Output, inserted!.Output);
    }

    [Fact]
    public void GetSummary_ReturnsLatestSummary()
    {
        var consultationId = Guid.NewGuid();
        var older = new SummaryDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Output = "Old summary",
            Type = "summary",
            Status = "pending_review",
            CreatedAt = new DateTime(2026, 1, 1, 8, 0, 0, DateTimeKind.Utc)
        };

        var latest = new SummaryDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Output = "Latest summary",
            Type = "summary",
            Status = "approved",
            CreatedAt = new DateTime(2026, 1, 2, 8, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out _,
            out var summaries,
            out _,
            out _);

        TestHelpers.SetupFindResult(summaries, older, latest);

        var service = new SummaryService(mongo, Mock.Of<ILLM>());

        var summary = service.GetSummary(consultationId);

        Assert.Equal(latest.CreatedAt, summary.CreatedAt);
        Assert.Equal(latest.Output, summary.Output);
        Assert.Equal(latest.Status, summary.Status);
    }
}

public class TranscriptServiceTests
{
    [Fact]
    public async Task GenerateTranscript_ReturnsAfterUploadingWavAudio()
    {
        var consultationId = Guid.NewGuid();
        var consultation = new ConsultationDocument
        {
            ConsultationId = consultationId,
            AppointmentId = Guid.NewGuid(),
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            PatientEmail = "viktor.orban@example.com"
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out var consultations,
            out _,
            out _,
            out var transcripts);

        TestHelpers.SetupFindResult(consultations, consultation);

        RawTranscriptDocument? inserted = null;
        transcripts
            .Setup(collection => collection.InsertOne(It.IsAny<RawTranscriptDocument>(), It.IsAny<InsertOneOptions>(), It.IsAny<CancellationToken>()))
            .Callback<RawTranscriptDocument, InsertOneOptions, CancellationToken>((document, _, _) => inserted = document);

        var speechToText = new Mock<ISpeechToText>();
        speechToText.Setup(service => service.TranscribeAsync(It.IsAny<Stream>())).ReturnsAsync("Patient says they feel better.");

        var service = new TranscriptService(mongo, speechToText.Object);
        var audio = TestHelpers.CreateAudioFile("consultation.wav");

        await service.GenerateTranscript(consultationId, audio);

        Assert.NotNull(inserted);
        Assert.Equal(consultationId, inserted!.AppointmentId);
        Assert.Equal(consultation.DoctorName, inserted.DoctorName);
        Assert.Equal("Patient says they feel better.", inserted.Transcription);
    }

    [Fact]
    public void GetTranscript_ReturnsStoredTranscript()
    {
        var consultationId = Guid.NewGuid();
        var transcript = new RawTranscriptDocument
        {
            AppointmentId = consultationId,
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            Transcription = "Patient feels well.",
            CreatedAt = new DateTime(2026, 3, 1, 8, 0, 0, DateTimeKind.Utc)
        };

        var mongo = TestHelpers.CreateMongoDbContext(
            out _,
            out _,
            out _,
            out var transcripts);

        TestHelpers.SetupFindResult(transcripts, transcript);

        var service = new TranscriptService(mongo, Mock.Of<ISpeechToText>());

        var result = service.GetTranscript(consultationId);

        Assert.Equal(transcript.AppointmentId, result.AppointmentId);
        Assert.Equal(transcript.Transcription, result.Transcription);
        Assert.Equal(transcript.DoctorName, result.DoctorName);
    }
}

internal static class TestHelpers
{
    internal static AppDbContext CreateAppDbContext(string databaseName)
    {
        var options = new DbContextOptionsBuilder<AppDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;

        return new AppDbContext(options);
    }

    internal static MongoDbContext CreateMongoDbContext(
        out Mock<IMongoCollection<ConsultationDocument>> consultations,
        out Mock<IMongoCollection<SummaryDocument>> summaries,
        out Mock<IMongoCollection<DoctorNoteDocument>> doctorNotes,
        out Mock<IMongoCollection<RawTranscriptDocument>> rawTranscripts)
    {
        var client = new Mock<IMongoClient>();
        var database = new Mock<IMongoDatabase>();

        consultations = new Mock<IMongoCollection<ConsultationDocument>>();
        summaries = new Mock<IMongoCollection<SummaryDocument>>();
        doctorNotes = new Mock<IMongoCollection<DoctorNoteDocument>>();
        rawTranscripts = new Mock<IMongoCollection<RawTranscriptDocument>>();

        client.Setup(mongoClient => mongoClient.GetDatabase(It.IsAny<string>(), It.IsAny<MongoDatabaseSettings>()))
            .Returns(database.Object);

        database.Setup(mongoDatabase => mongoDatabase.GetCollection<ConsultationDocument>(It.IsAny<string>(), It.IsAny<MongoCollectionSettings>()))
            .Returns(consultations.Object);
        database.Setup(mongoDatabase => mongoDatabase.GetCollection<SummaryDocument>(It.IsAny<string>(), It.IsAny<MongoCollectionSettings>()))
            .Returns(summaries.Object);
        database.Setup(mongoDatabase => mongoDatabase.GetCollection<DoctorNoteDocument>(It.IsAny<string>(), It.IsAny<MongoCollectionSettings>()))
            .Returns(doctorNotes.Object);
        database.Setup(mongoDatabase => mongoDatabase.GetCollection<RawTranscriptDocument>(It.IsAny<string>(), It.IsAny<MongoCollectionSettings>()))
            .Returns(rawTranscripts.Object);

        return new MongoDbContext(
            client.Object,
            Options.Create(new MongoDbSettings
            {
                ConnectionString = "mongodb://localhost",
                DatabaseName = "consultation-tests"
            }));
    }

    internal static void SetupFindResult<T>(Mock<IMongoCollection<T>> collection, params T[] documents) where T : class
    {
        var cursor = CreateCursor(documents);

        collection.Setup(mongoCollection => mongoCollection.FindSync(It.IsAny<FilterDefinition<T>>(), It.IsAny<FindOptions<T, T>>(), It.IsAny<CancellationToken>()))
            .Returns(cursor.Object);

        collection.Setup(mongoCollection => mongoCollection.FindAsync(It.IsAny<FilterDefinition<T>>(), It.IsAny<FindOptions<T, T>>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(cursor.Object);
    }

    internal static Mock<IAsyncCursor<T>> CreateCursor<T>(IReadOnlyCollection<T> documents)
    {
        var cursor = new Mock<IAsyncCursor<T>>();

        cursor.SetupSequence(result => result.MoveNext(It.IsAny<CancellationToken>()))
            .Returns(true)
            .Returns(false);
        cursor.SetupSequence(result => result.MoveNextAsync(It.IsAny<CancellationToken>()))
            .ReturnsAsync(true)
            .ReturnsAsync(false);
        cursor.SetupGet(result => result.Current).Returns(documents.ToList());

        return cursor;
    }

    internal static IFormFile CreateAudioFile(string fileName)
    {
        var stream = new MemoryStream(new byte[] { 1, 2, 3, 4 });
        return new FormFile(stream, 0, stream.Length, "audio", fileName);
    }

    internal static Appointment CreateAppointment(Guid appointmentId, AppointmentStatus status)
    {
        return new Appointment
        {
            AppointmentId = appointmentId,
            DocId = Guid.NewGuid(),
            PatId = Guid.NewGuid(),
            AppointmentDate = new DateOnly(2026, 1, 1),
            AppointmentTime = new TimeOnly(9, 0),
            AppointmentStatus = status,
            CreatedAt = new DateTime(2026, 1, 1, 8, 0, 0, DateTimeKind.Utc)
        };
    }

    internal static BookingRequest CreateBookingRequest()
    {
        return new BookingRequest
        {
            BookingId = Guid.NewGuid(),
            DoctorId = Guid.NewGuid(),
            DoctorName = "Dr Peter Magyar",
            PatientId = Guid.NewGuid(),
            PatientName = "Viktor Orban",
            PatientEmail = "viktor.orban@example.com"
        };
    }
}