using System;
using BookingBackend.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace BookingBackend.Data.Migrations
{
    [DbContext(typeof(BookingDbContext))]
    [Migration("20260320140630_InitialCreate")]
    partial class InitialCreate
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "10.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("BookingBackend.Models.Appointment", b =>
                {
                    b.Property<int>("AppointmentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("AppointmentId"));

                    b.Property<DateOnly>("AppointmentDate")
                        .HasColumnType("date");

                    b.Property<TimeOnly>("AppointmentTime")
                        .HasColumnType("time without time zone");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int>("DocId")
                        .HasColumnType("integer");

                    b.Property<bool>("EmailConfirmationSent")
                        .HasColumnType("boolean");

                    b.Property<DateTime?>("EmailSentAt")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int>("PatId")
                        .HasColumnType("integer");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("AppointmentId");

                    b.HasIndex("PatId");

                    b.HasIndex("DocId", "AppointmentDate", "AppointmentTime")
                        .IsUnique();

                    b.ToTable("Appointments");
                });

            modelBuilder.Entity("BookingBackend.Models.Doctor", b =>
                {
                    b.Property<int>("DocId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("DocId"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("DocId");

                    b.ToTable("Doctors");
                });

            modelBuilder.Entity("BookingBackend.Models.Patient", b =>
                {
                    b.Property<int>("PatId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("PatId"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("PatId");

                    b.ToTable("Patients");
                });

            modelBuilder.Entity("BookingBackend.Models.WorksOn", b =>
                {
                    b.Property<int>("DocId")
                        .HasColumnType("integer");

                    b.Property<int>("DayOfTheWeek")
                        .HasColumnType("integer");

                    b.Property<TimeOnly>("EndsAt")
                        .HasColumnType("time without time zone");

                    b.Property<TimeOnly>("StartsFrom")
                        .HasColumnType("time without time zone");

                    b.HasKey("DocId", "DayOfTheWeek");

                    b.ToTable("WorksOn");
                });

            modelBuilder.Entity("BookingBackend.Models.Appointment", b =>
                {
                    b.HasOne("BookingBackend.Models.Doctor", "Doctor")
                        .WithMany("Appointments")
                        .HasForeignKey("DocId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("BookingBackend.Models.Patient", "Patient")
                        .WithMany("Appointments")
                        .HasForeignKey("PatId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doctor");

                    b.Navigation("Patient");
                });

            modelBuilder.Entity("BookingBackend.Models.WorksOn", b =>
                {
                    b.HasOne("BookingBackend.Models.Doctor", "Doctor")
                        .WithMany("WorksOn")
                        .HasForeignKey("DocId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doctor");
                });

            modelBuilder.Entity("BookingBackend.Models.Doctor", b =>
                {
                    b.Navigation("Appointments");

                    b.Navigation("WorksOn");
                });

            modelBuilder.Entity("BookingBackend.Models.Patient", b =>
                {
                    b.Navigation("Appointments");
                });
#pragma warning restore 612, 618
        }
    }
}
