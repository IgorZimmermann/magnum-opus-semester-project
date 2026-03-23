using BookingBackend.Models;
using Microsoft.EntityFrameworkCore;

namespace BookingBackend.Interfaces
{
    public interface IRelationalDb
    {
        DbSet<Doctor> Doctors { get; }
        DbSet<Patient> Patients { get; }
        DbSet<WorksOn> WorksOn { get; }
        DbSet<Appointment> Appointments { get; }

        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
    }
}
