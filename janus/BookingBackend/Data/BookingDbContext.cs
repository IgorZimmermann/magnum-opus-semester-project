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
        }
    }
}
