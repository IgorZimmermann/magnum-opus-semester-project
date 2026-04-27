using BookingBackend.Data;
using BookingBackend.DTO;
using BookingBackend.Models;
using Microsoft.EntityFrameworkCore;

namespace BookingBackend.Tests;

internal static class TestHelpers
{
    internal static BookingDbContext CreateDbContext(string databaseName)
    {
        var options = new DbContextOptionsBuilder<BookingDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;

        return new BookingDbContext(options);
    }

    internal static Doctor CreateDoctor() => new Doctor
    {
        DocId = Guid.NewGuid(),
        Name = "Dr. Gregory House",
        Email = "house@hospital.com"
    };

    internal static Patient CreatePatient() => new Patient
    {
        PatId = Guid.NewGuid(),
        Name = "John Doe",
        Email = "john.doe@example.com"
    };

    internal static WorksOn CreateWorksOn(Guid docId, int dayOfWeek) => new WorksOn
    {
        DocId = docId,
        DayOfTheWeek = dayOfWeek,
        StartsFrom = new TimeOnly(9, 0),
        EndsAt = new TimeOnly(17, 0)
    };

    internal static CreateAppointmentDTO CreateAppointmentDTO(Guid docId, Guid patId) => new CreateAppointmentDTO
    {
        DocId = docId,
        PatId = patId,
        AppointmentDate = new DateOnly(2026, 5, 1),
        AppointmentTime = new TimeOnly(10, 0)
    };

    internal static Appointment CreateAppointment(Guid docId, Guid patId, TimeOnly? time = null) => new Appointment
    {
        AppointmentId = Guid.NewGuid(),
        DocId = docId,
        PatId = patId,
        AppointmentDate = new DateOnly(2026, 5, 1),
        AppointmentTime = time ?? new TimeOnly(10, 0),
        Status = AppointmentStatus.Confirmed,
        CreatedAt = new DateTime(2026, 5, 1, 9, 0, 0, DateTimeKind.Utc)
    };
}
