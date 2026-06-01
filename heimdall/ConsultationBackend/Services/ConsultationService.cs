using System.Threading.Tasks;
using ConsultationBackend.Data;
using ConsultationBackend.Dtos;
using ConsultationBackend.DTOs;
using ConsultationBackend.Infrastructure;
using ConsultationBackend.Interfaces.Infrastructure;
using ConsultationBackend.Interfaces.Services;
using ConsultationBackend.Models.NonRelational;
using ConsultationBackend.Models.Relational;
using Microsoft.EntityFrameworkCore;
using MongoDB.Driver;

namespace ConsultationBackend.Services;

public class ConsultationService : IConsultationService
{
    private readonly AppDbContext _context;
    private readonly MongoDbContext _mongo;

    private readonly ISpeechToText _speechToText;

    public ConsultationService(AppDbContext context, MongoDbContext mongo, ISpeechToText speechToText)
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

    public void CompleteConsultation(Guid consultationId)
    {
        var filter = Builders<ConsultationDocument>.Filter.Eq(c => c.ConsultationId, consultationId);
        var doc = _mongo.Consultations.Find(filter).FirstOrDefault() ?? throw new KeyNotFoundException("Consultation not found");

        var appointment = _context.Appointments.FirstOrDefault(a => a.AppointmentId == doc.AppointmentId)
            ?? throw new KeyNotFoundException("Appointment not found");

        _context.Appointments.Remove(appointment);
        _context.SaveChanges();
    }

    // Accepts doctor email
    // Returns doctor appointment, max 10
    // it returns a list of AppointmentSummaryResponse DTO
    public List<AppointmentSummaryResponse> GetDoctorAppointments(string email)
    {
        var doctor = _context.Doctors.FirstOrDefault(d => d.Email == email)
                     ?? throw new KeyNotFoundException("Doctor not found");

        return _context.Appointments
            .Include(a => a.Patient)
            .Where(a => a.DocId == doctor.DocId)
            .OrderBy(a => a.AppointmentDate)
            .ThenBy(a => a.AppointmentTime)
            .Take(10)
            .Select(a => new AppointmentSummaryResponse
            {
                AppointmentId = a.AppointmentId,
                PatientName = a.Patient!.Name,
                PatientEmail = a.Patient!.Email,
                AppointmentDate = a.AppointmentDate,
                AppointmentTime = a.AppointmentTime,
                AppointmentStatus = a.AppointmentStatus.ToString()
            })
            .ToList();
    }

}