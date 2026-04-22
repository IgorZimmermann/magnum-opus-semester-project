using BookingBackend.Models;
using BookingBackend.Services.Implementations;
using Xunit;

namespace BookingBackend.Tests;

public class AvailabilityServiceTests
{
    [Fact]
    public async Task GetAllDoctorsAvailabilityAsync_ReturnsMappedDoctor_WithSlots()
    {
        var context = TestHelpers.CreateDbContext("Availability_WithSlots");
        var doctor = TestHelpers.CreateDoctor();
        context.Doctors.Add(doctor);
        context.WorksOn.Add(TestHelpers.CreateWorksOn(doctor.DocId, 1));
        context.WorksOn.Add(TestHelpers.CreateWorksOn(doctor.DocId, 3));
        await context.SaveChangesAsync();

        var service = new AvailabilityService(context);

        var result = await service.GetAllDoctorsAvailabilityAsync();

        Assert.Single(result);
        var availability = result[0];
        Assert.Equal(doctor.DocId, availability.DocId);
        Assert.Equal(doctor.Name, availability.Name);
        Assert.Equal(2, availability.AvailabilitySlots.Count);
        Assert.Contains(availability.AvailabilitySlots, s => s.DayOfTheWeek == 1);
        Assert.Contains(availability.AvailabilitySlots, s => s.DayOfTheWeek == 3);
    }

    [Fact]
    public async Task GetAllDoctorsAvailabilityAsync_MapsSlotTimeRange_Correctly()
    {
        var context = TestHelpers.CreateDbContext("Availability_SlotTimes");
        var doctor = TestHelpers.CreateDoctor();
        context.Doctors.Add(doctor);
        context.WorksOn.Add(new WorksOn
        {
            DocId = doctor.DocId,
            DayOfTheWeek = 2,
            StartsFrom = new TimeOnly(8, 30),
            EndsAt = new TimeOnly(16, 0)
        });
        await context.SaveChangesAsync();

        var service = new AvailabilityService(context);

        var result = await service.GetAllDoctorsAvailabilityAsync();

        var slot = result[0].AvailabilitySlots[0];
        Assert.Equal(2, slot.DayOfTheWeek);
        Assert.Equal(new TimeOnly(8, 30), slot.StartsFrom);
        Assert.Equal(new TimeOnly(16, 0), slot.EndsAt);
    }

    [Fact]
    public async Task GetAllDoctorsAvailabilityAsync_ReturnsAllDoctors_WhenMultipleExist()
    {
        var context = TestHelpers.CreateDbContext("Availability_MultipleDoctors");
        var doctor1 = TestHelpers.CreateDoctor();
        var doctor2 = TestHelpers.CreateDoctor();
        context.Doctors.Add(doctor1);
        context.Doctors.Add(doctor2);
        context.WorksOn.Add(TestHelpers.CreateWorksOn(doctor1.DocId, 1));
        context.WorksOn.Add(TestHelpers.CreateWorksOn(doctor2.DocId, 2));
        await context.SaveChangesAsync();

        var service = new AvailabilityService(context);

        var result = await service.GetAllDoctorsAvailabilityAsync();

        Assert.Equal(2, result.Count);
        Assert.Contains(result, d => d.DocId == doctor1.DocId);
        Assert.Contains(result, d => d.DocId == doctor2.DocId);
    }
}
