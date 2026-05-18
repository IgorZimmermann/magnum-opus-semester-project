using BookingBackend.Models;
using BookingBackend.Interfaces;
using Microsoft.EntityFrameworkCore;
using BookingBackend.Interfaces;

namespace BookingBackend.Data
{
    public class BookingDbContext : DbContext, IRelationalDb
    {
        public BookingDbContext(DbContextOptions<BookingDbContext> options) : base(options)
        {
        }

        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<WorksOn> WorksOn { get; set; }
        public DbSet<Appointment> Appointments { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Doctor
            modelBuilder.Entity<Doctor>()
                .ToTable("doctors")
                .HasKey(d => d.DocId);

            // Patient
            modelBuilder.Entity<Patient>()
                .ToTable("patients")
                .HasKey(p => p.PatId);

            // WorksOn (composite key)
            modelBuilder.Entity<WorksOn>()
                .ToTable("workson")
                .HasKey(w => new { w.DocId, w.DayOfTheWeek });

            modelBuilder.Entity<WorksOn>()
                .HasOne(w => w.Doctor)
                .WithMany(d => d.WorksOn)
                .HasForeignKey(w => w.DocId)
                .OnDelete(DeleteBehavior.Cascade);

            // Appointment
            modelBuilder.Entity<Appointment>()
                .ToTable("appointments")
                .HasKey(a => a.AppointmentId);

            modelBuilder.Entity<Appointment>()
                .HasOne(a => a.Doctor)
                .WithMany(d => d.Appointments)
                .HasForeignKey(a => a.DocId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Appointment>()
                .HasOne(a => a.Patient)
                .WithMany(p => p.Appointments)
                .HasForeignKey(a => a.PatId)
                .OnDelete(DeleteBehavior.Cascade);

            // Unique constraint
            modelBuilder.Entity<Appointment>()
                .HasIndex(a => new { a.DocId, a.AppointmentDate, a.AppointmentTime })
                .IsUnique();

            // Status enum as string — column is named AppointmentStatus in the shared DB
            modelBuilder.Entity<Appointment>()
                .Property(a => a.Status)
                .HasColumnName("AppointmentStatus")
                .HasConversion<string>();

            var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
            var docBenId = Guid.Parse("22222222-2222-2222-2222-222222222222");
            modelBuilder.Entity<WorksOn>().HasData(
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 0, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 1, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 2, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 3, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 4, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 5, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docAliceId, DayOfTheWeek = 6, StartsFrom = new TimeOnly(0, 0), EndsAt = new TimeOnly(23, 59) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 1, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 2, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 3, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 4, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 5, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) },
                new WorksOn { DocId = docBenId, DayOfTheWeek = 6, StartsFrom = new TimeOnly(9, 0), EndsAt = new TimeOnly(17, 0) }
            );
        }
    }
}
