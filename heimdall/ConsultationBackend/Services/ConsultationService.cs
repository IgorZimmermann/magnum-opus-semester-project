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


    // Accepts consultationId
    // Returns a doc of consultation information
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