using ConsultationBackend.Models.Relational;
using Microsoft.EntityFrameworkCore;


namespace ConsultationBackend.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
        
    }

    public DbSet<Doctor> Doctors => Set<Doctor>();
    public DbSet<Patient> Patients => Set<Patient>();
    public DbSet<Appointment> Appointments => Set<Appointment>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Doctor>(entity =>
        {
            entity.ToTable("doctors");
            entity.HasKey(d => d.DocId);
            entity.Property(d => d.DocId)
                .HasColumnType("uuid")
                .HasDefaultValueSql("gen_random_uuid()")
                .ValueGeneratedOnAdd();
            entity.Property(d => d.Name).IsRequired().HasMaxLength(200);
            entity.Property(d => d.Email).IsRequired().HasMaxLength(320);
            entity.HasIndex(d => d.Email).IsUnique();
        });

        modelBuilder.Entity<Patient>(entity =>
        {
            entity.ToTable("patients");
            entity.HasKey(p => p.PatId);
            entity.Property(p => p.PatId)
                .HasColumnType("uuid")
                .HasDefaultValueSql("gen_random_uuid()")
                .ValueGeneratedOnAdd();
            entity.Property(p => p.Name).IsRequired().HasMaxLength(200);
            entity.Property(p => p.Email).IsRequired().HasMaxLength(320);
            entity.HasIndex(p => p.Email).IsUnique();
        });

        modelBuilder.Entity<Appointment>(entity =>
        {
            entity.ToTable("appointments");
            entity.HasKey(a => a.AppointmentId);
            entity.Property(a => a.AppointmentId)
                .HasColumnType("uuid")
                .HasDefaultValueSql("gen_random_uuid()")
                .ValueGeneratedOnAdd();
            entity.Property(a => a.AppointmentDate).HasColumnType("date");
            entity.Property(a => a.AppointmentTime).HasColumnType("time without time zone");
            entity.Property(a => a.EmailConfirmationSent).HasDefaultValue(false);
            entity.Property(a => a.CreatedAt).HasColumnType("timestamp with time zone");
            entity.Property(a => a.EmailSentAt).HasColumnType("timestamp with time zone");
            entity.Property(a => a.AppointmentStatus).HasConversion<string>().HasMaxLength(32);

            entity.HasIndex(a => a.DocId);
            entity.HasIndex(a => a.PatId);
            entity.HasIndex(a => new { a.AppointmentDate, a.AppointmentTime });

            entity.HasOne(a => a.Doctor)
                .WithMany(d => d.Appointments)
                .HasForeignKey(a => a.DocId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(a => a.Patient)
                .WithMany(p => p.Appointments)
                .HasForeignKey(a => a.PatId)
                .OnDelete(DeleteBehavior.Restrict);
        });
        var docAliceId = Guid.Parse("11111111-1111-1111-1111-111111111111");
        var docBenId   = Guid.Parse("22222222-2222-2222-2222-222222222222");
        var patJohnId  = Guid.Parse("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
        var patJaneId  = Guid.Parse("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb");
        var appt1Id    = Guid.Parse("cccccccc-cccc-cccc-cccc-cccccccccccc");
        var appt2Id    = Guid.Parse("dddddddd-dddd-dddd-dddd-dddddddddddd");

        modelBuilder.Entity<Doctor>().HasData(
            new Doctor { DocId = docAliceId, Name = "Dr. Alice Carter", Email = "alice.carter@example.com" },
            new Doctor { DocId = docBenId,   Name = "Dr. Ben Ortiz",    Email = "ben.ortiz@example.com" }
        );

        modelBuilder.Entity<Patient>().HasData(
            new Patient { PatId = patJohnId, Name = "John Doe",  Email = "john.doe@example.com" },
            new Patient { PatId = patJaneId, Name = "Jane Smith", Email = "jane.smith@example.com" }
        );

        modelBuilder.Entity<Appointment>().HasData(
            new Appointment
            {
                AppointmentId = appt1Id,
                DocId = docAliceId,
                PatId = patJohnId,
                AppointmentDate = new DateOnly(2026, 1, 15),
                AppointmentTime = new TimeOnly(9, 0),
                EmailConfirmationSent = false,
                CreatedAt = new DateTime(2026, 1, 1, 12, 0, 0, DateTimeKind.Utc),
                AppointmentStatus = AppointmentStatus.Confirmed
            },
            new Appointment
            {
                AppointmentId = appt2Id,
                DocId = docBenId,
                PatId = patJaneId,
                AppointmentDate = new DateOnly(2026, 1, 16),
                AppointmentTime = new TimeOnly(10, 30),
                EmailConfirmationSent = true,
                EmailSentAt = new DateTime(2026, 1, 10, 8, 0, 0, DateTimeKind.Utc),
                CreatedAt = new DateTime(2026, 1, 5, 12, 0, 0, DateTimeKind.Utc),
                AppointmentStatus = AppointmentStatus.Completed
            }
        );

        base.OnModelCreating(modelBuilder);
    }
}
