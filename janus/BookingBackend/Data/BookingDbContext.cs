using BookingBackend.Models;
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
                .HasKey(d => d.DocId);

            // Patient
            modelBuilder.Entity<Patient>()
                .HasKey(p => p.PatId);

            // WorksOn (composite key)
            modelBuilder.Entity<WorksOn>()
                .HasKey(w => new { w.DocId, w.DayOfTheWeek });

            modelBuilder.Entity<WorksOn>()
                .HasOne(w => w.Doctor)
                .WithMany(d => d.WorksOn)
                .HasForeignKey(w => w.DocId)
                .OnDelete(DeleteBehavior.Cascade);

            // Appointment
            modelBuilder.Entity<Appointment>()
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

            // Status enum as string
            modelBuilder.Entity<Appointment>()
                .Property(a => a.Status)
                .HasConversion<string>();
        }
    }
}
