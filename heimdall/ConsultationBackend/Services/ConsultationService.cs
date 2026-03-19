using System.Threading.Tasks;
using ConsultationBackend.Data;
using ConsultationBackend.Dtos;
using ConsultationBackend.DTOs;
using ConsultationBackend.Infrastructure;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Models.NonRelational;
using ConsultationBackend.Models.Relational;

using MongoDB.Driver;

namespace ConsultationBackend.Services;

public class ConsultationService : IConsultationService
{
    private readonly AppDbContext _context;
    private readonly MongoDbContext _mongo;

    private readonly IspeechToText _speechToText;

    public ConsultationService(AppDbContext context, MongoDbContext mongo, IspeechToText speechToText)
    {
        _context = context;
        _mongo = mongo;
        _speechToText = speechToText;
    }


    // Accepts BookingRequest (Doctor id, name, patient id, name, email, booking id, etc)
    // If found in the db it will create a new document in mongo Db called ConsulationDocument
    public Guid StartConsultation(BookingRequest request)
    {
        var booking = _context.Appointments.FirstOrDefault(b => b.AppointmentId == request.BookingId);

        if (booking == null)
        {
            throw new KeyNotFoundException("Booking not found");
        }

        if (booking.AppointmentStatus != AppointmentStatus.Confirmed)
        {
            throw new InvalidOperationException("Booking is not confirmed");
        }
        
        var doc = new ConsultationDocument
        {
            ConsultationId = Guid.NewGuid(),
            AppointmentId = request.BookingId,
            DoctorId = request.DoctorId,
            DoctorName = request.DoctorName,
            PatientId = request.PatientId,
            PatientName = request.PatientName,
            PatientEmail = request.PatientEmail
        };

        _mongo.Consultations.InsertOne(doc);

        Console.WriteLine($"Starting consultation with booking number: {doc.ConsultationId}");

        return doc.ConsultationId;
    }

    // Accepts consultaionId with the Audio file
    //  It finds the consultaiton
    // If found it will use the speechToText infrastructure to transcribe it
    // Then it will create a new doc called SummaryDocument and save it in the db
    public async Task UploadAudio(Guid consultationId, IFormFile audio)
    {
        Console.WriteLine($"Uploaded audio for consultation: {consultationId}");
        
        var filter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);

        var consult = _mongo.Consultations.Find(filter).FirstOrDefault();

        if (consult is null)
        {
            throw new KeyNotFoundException("Consultation not found");
        } 

        if (audio is null)
        {
            throw new ArgumentNullException("Audio file cannot be nul   l");
        }

   
        if (!audio.FileName.EndsWith(".wav", StringComparison.OrdinalIgnoreCase))
        {
            throw new InvalidOperationException("Only .wav files are allowed");
        }

        using var stream = audio.OpenReadStream();

        string transcript = await _speechToText.TranscribeAsync(stream);

        var doc = new SummaryDocument
        {
            AppointmentId = consultationId,
            Output = transcript,
            Type = "Summary",
            Status = "pending_review",
        };

        _mongo.Summaries.InsertOne(doc);

        Console.WriteLine($"Audio file uploaded and transcribed with booking number: {consultationId}");
    }

    // Accepts consultationId
    // Returns a doc of consultaion information
    public ConsultationResponse GetConsultation(Guid consultationId)
    {
        var filter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);
        var doc = _mongo.Consultations.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Consultation not found");

        return new ConsultationResponse
        {
            ConsultationId = doc.ConsultationId,
            AppointmentId = doc.AppointmentId,
            DoctorId = doc.DoctorId,
            DoctorName = doc.DoctorName,
            PatientId = doc.PatientId,
            PatientName = doc.PatientName,
            PatientEmail = doc.PatientEmail,
            Status = doc.Status,
            CreatedAt = doc.CreatedAt
        };
    }
}