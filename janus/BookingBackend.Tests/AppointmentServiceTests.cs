using BookingBackend.DTO;
using BookingBackend.Interfaces;
using BookingBackend.Services.Implementations;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;

namespace BookingBackend.Tests;

public class AppointmentServiceTests
{
    [Fact]
    public async Task SaveAppointmentAsync_ReturnsDTO_WithCorrectFields()
    {
        var context = TestHelpers.CreateDbContext("Save_Returns_DTO");
        var doctor = TestHelpers.CreateDoctor();
        var patient = TestHelpers.CreatePatient();
        context.Doctors.Add(doctor);
        context.Patients.Add(patient);
        await context.SaveChangesAsync();

        var emailService = new Mock<IEmail>();
        emailService.Setup(e => e.SendEmailAsync(It.IsAny<EmailGenerateRequest>())).ReturnsAsync(true);

        var service = new AppointmentService(context, emailService.Object);
        var dto = TestHelpers.CreateAppointmentDTO(doctor.DocId, patient.PatId);

        var result = await service.SaveAppointmentAsync(dto);

        Assert.NotEqual(Guid.Empty, result.AppointmentId);
        Assert.Equal(dto.DocId, result.DocId);
        Assert.Equal(dto.PatId, result.PatId);
        Assert.Equal(dto.AppointmentDate, result.AppointmentDate);
        Assert.Equal(dto.AppointmentTime, result.AppointmentTime);
        Assert.Equal("Confirmed", result.Status);
    }

    [Fact]
    public async Task SaveAppointmentAsync_PersistsAppointment_ToDatabase()
    {
        var context = TestHelpers.CreateDbContext("Save_Persists");
        var doctor = TestHelpers.CreateDoctor();
        var patient = TestHelpers.CreatePatient();
        context.Doctors.Add(doctor);
        context.Patients.Add(patient);
        await context.SaveChangesAsync();

        var emailService = new Mock<IEmail>();
        emailService.Setup(e => e.SendEmailAsync(It.IsAny<EmailGenerateRequest>())).ReturnsAsync(false);

        var service = new AppointmentService(context, emailService.Object);
        var dto = TestHelpers.CreateAppointmentDTO(doctor.DocId, patient.PatId);

        var result = await service.SaveAppointmentAsync(dto);

        var saved = await context.Appointments.FindAsync(result.AppointmentId);
        Assert.NotNull(saved);
        Assert.Equal(dto.DocId, saved!.DocId);
        Assert.Equal(dto.PatId, saved.PatId);
    }

    [Fact]
    public async Task SaveAppointmentAsync_SetsEmailSentAt_WhenEmailSucceeds()
    {
        var context = TestHelpers.CreateDbContext("Save_SetsEmailSentAt");
        var doctor = TestHelpers.CreateDoctor();
        var patient = TestHelpers.CreatePatient();
        context.Doctors.Add(doctor);
        context.Patients.Add(patient);
        await context.SaveChangesAsync();

        var emailService = new Mock<IEmail>();
        emailService.Setup(e => e.SendEmailAsync(It.IsAny<EmailGenerateRequest>())).ReturnsAsync(true);

        var service = new AppointmentService(context, emailService.Object);
        var dto = TestHelpers.CreateAppointmentDTO(doctor.DocId, patient.PatId);

        await service.SaveAppointmentAsync(dto);

        var saved = await context.Appointments.FirstAsync();
        Assert.NotNull(saved.EmailSentAt);
    }

    [Fact]
    public async Task SaveAppointmentAsync_SendsEmailToPatient_WithDoctorName()
    {
        var context = TestHelpers.CreateDbContext("Save_SendsEmail");
        var doctor = TestHelpers.CreateDoctor();
        var patient = TestHelpers.CreatePatient();
        context.Doctors.Add(doctor);
        context.Patients.Add(patient);
        await context.SaveChangesAsync();

        EmailGenerateRequest? capturedRequest = null;
        var emailService = new Mock<IEmail>();
        emailService
            .Setup(e => e.SendEmailAsync(It.IsAny<EmailGenerateRequest>()))
            .Callback<EmailGenerateRequest>(req => capturedRequest = req)
            .ReturnsAsync(true);

        var service = new AppointmentService(context, emailService.Object);
        var dto = TestHelpers.CreateAppointmentDTO(doctor.DocId, patient.PatId);

        await service.SaveAppointmentAsync(dto);

        Assert.NotNull(capturedRequest);
        Assert.Contains(patient.Email, capturedRequest!.ToEmails);
        Assert.Contains(doctor.Name, capturedRequest.Text);
    }

    [Fact]
    public async Task GetAppointmentsAsync_ReturnsMappedDTOs_ForAllAppointments()
    {
        var context = TestHelpers.CreateDbContext("GetAll_Returns_DTOs");
        var docId = Guid.NewGuid();
        var patId = Guid.NewGuid();
        context.Appointments.Add(TestHelpers.CreateAppointment(docId, patId, new TimeOnly(10, 0)));
        context.Appointments.Add(TestHelpers.CreateAppointment(docId, patId, new TimeOnly(11, 0)));
        await context.SaveChangesAsync();

        var service = new AppointmentService(context, Mock.Of<IEmail>());

        var result = await service.GetAppointmentsAsync();

        Assert.Equal(2, result.Count);
        Assert.All(result, a =>
        {
            Assert.NotEqual(Guid.Empty, a.AppointmentId);
            Assert.Equal(docId, a.DocId);
            Assert.Equal(patId, a.PatId);
            Assert.Equal("Confirmed", a.Status);
        });
    }
}
