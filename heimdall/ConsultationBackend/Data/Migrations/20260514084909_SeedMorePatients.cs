using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ConsultationBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class SeedMorePatients : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "patients",
                columns: new[] { "PatId", "Email", "Name" },
                values: new object[,]
                {
                    { new Guid("33333333-3333-3333-3333-333333333333"), "bob.johnson@example.com", "Bob Johnson" },
                    { new Guid("44444444-4444-4444-4444-444444444444"), "carol.williams@example.com", "Carol Williams" },
                    { new Guid("55555555-5555-5555-5555-555555555555"), "david.brown@example.com", "David Brown" },
                    { new Guid("66666666-6666-6666-6666-666666666666"), "emily.davis@example.com", "Emily Davis" }
                });

            migrationBuilder.InsertData(
                table: "appointments",
                columns: new[] { "AppointmentId", "AppointmentDate", "AppointmentStatus", "AppointmentTime", "CreatedAt", "DocId", "EmailSentAt", "PatId" },
                values: new object[,]
                {
                    { new Guid("aaaaaaaa-1111-1111-1111-111111111111"), new DateOnly(2026, 1, 15), "Confirmed", new TimeOnly(13, 0, 0), new DateTime(2026, 1, 1, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("11111111-1111-1111-1111-111111111111"), null, new Guid("55555555-5555-5555-5555-555555555555") },
                    { new Guid("bbbbbbbb-1111-1111-1111-111111111111"), new DateOnly(2026, 1, 15), "Confirmed", new TimeOnly(14, 0, 0), new DateTime(2026, 1, 1, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("11111111-1111-1111-1111-111111111111"), null, new Guid("66666666-6666-6666-6666-666666666666") },
                    { new Guid("eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee"), new DateOnly(2026, 1, 15), "Confirmed", new TimeOnly(10, 0, 0), new DateTime(2026, 1, 1, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("11111111-1111-1111-1111-111111111111"), null, new Guid("33333333-3333-3333-3333-333333333333") },
                    { new Guid("ffffffff-ffff-ffff-ffff-ffffffffffff"), new DateOnly(2026, 1, 15), "Confirmed", new TimeOnly(11, 0, 0), new DateTime(2026, 1, 1, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("11111111-1111-1111-1111-111111111111"), null, new Guid("44444444-4444-4444-4444-444444444444") }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValue: new Guid("aaaaaaaa-1111-1111-1111-111111111111"));

            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValue: new Guid("bbbbbbbb-1111-1111-1111-111111111111"));

            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValue: new Guid("eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee"));

            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValue: new Guid("ffffffff-ffff-ffff-ffff-ffffffffffff"));

            migrationBuilder.DeleteData(
                table: "patients",
                keyColumn: "PatId",
                keyValue: new Guid("33333333-3333-3333-3333-333333333333"));

            migrationBuilder.DeleteData(
                table: "patients",
                keyColumn: "PatId",
                keyValue: new Guid("44444444-4444-4444-4444-444444444444"));

            migrationBuilder.DeleteData(
                table: "patients",
                keyColumn: "PatId",
                keyValue: new Guid("55555555-5555-5555-5555-555555555555"));

            migrationBuilder.DeleteData(
                table: "patients",
                keyColumn: "PatId",
                keyValue: new Guid("66666666-6666-6666-6666-666666666666"));
        }
    }
}
