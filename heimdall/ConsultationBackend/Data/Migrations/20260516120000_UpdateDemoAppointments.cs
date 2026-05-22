using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ConsultationBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class UpdateDemoAppointments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Move Alice's two remaining appointments to future dates.
            migrationBuilder.Sql(@"
                UPDATE appointments
                SET ""AppointmentDate"" = '2026-06-10',
                    ""AppointmentTime"" = '09:00:00',
                    ""CreatedAt""       = '2026-05-16T12:00:00Z',
                    ""AppointmentStatus"" = 'Confirmed',
                    ""EmailConfirmationSent"" = true,
                    ""EmailSentAt"" = '2026-05-16T08:00:00Z'
                WHERE ""AppointmentId"" = 'cccccccc-cccc-cccc-cccc-cccccccccccc';
            ");

            migrationBuilder.Sql(@"
                UPDATE appointments
                SET ""AppointmentDate"" = '2026-06-10',
                    ""AppointmentTime"" = '10:00:00',
                    ""CreatedAt""       = '2026-05-16T12:00:00Z',
                    ""AppointmentStatus"" = 'Confirmed',
                    ""EmailConfirmationSent"" = false
                WHERE ""AppointmentId"" = 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee';
            ");

            // Move Ben's appointment to a future date.
            migrationBuilder.Sql(@"
                UPDATE appointments
                SET ""AppointmentDate"" = '2026-06-11',
                    ""AppointmentTime"" = '10:30:00',
                    ""CreatedAt""       = '2026-05-16T12:00:00Z',
                    ""AppointmentStatus"" = 'Confirmed',
                    ""EmailConfirmationSent"" = true,
                    ""EmailSentAt"" = '2026-05-16T08:00:00Z'
                WHERE ""AppointmentId"" = 'dddddddd-dddd-dddd-dddd-dddddddddddd';
            ");

            // Remove Alice's extra appointments (Carol, David, Emily) — keep max 2 for Alice.
            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValues: new object[]
                {
                    new Guid("ffffffff-ffff-ffff-ffff-ffffffffffff"),
                    new Guid("aaaaaaaa-1111-1111-1111-111111111111"),
                    new Guid("bbbbbbbb-1111-1111-1111-111111111111")
                });

            // Add Ben's two additional upcoming appointments.
            migrationBuilder.InsertData(
                table: "appointments",
                columns: new[] { "AppointmentId", "AppointmentDate", "AppointmentStatus", "AppointmentTime", "CreatedAt", "DocId", "EmailConfirmationSent", "PatId" },
                values: new object[,]
                {
                    {
                        new Guid("11111111-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
                        new DateOnly(2026, 6, 17),
                        "Confirmed",
                        new TimeOnly(9, 0, 0),
                        new DateTime(2026, 5, 16, 12, 0, 0, DateTimeKind.Utc),
                        new Guid("22222222-2222-2222-2222-222222222222"),
                        false,
                        new Guid("33333333-3333-3333-3333-333333333333")
                    },
                    {
                        new Guid("22222222-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
                        new DateOnly(2026, 6, 17),
                        "Confirmed",
                        new TimeOnly(10, 30, 0),
                        new DateTime(2026, 5, 16, 12, 0, 0, DateTimeKind.Utc),
                        new Guid("22222222-2222-2222-2222-222222222222"),
                        false,
                        new Guid("44444444-4444-4444-4444-444444444444")
                    }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "appointments",
                keyColumn: "AppointmentId",
                keyValues: new object[]
                {
                    new Guid("11111111-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
                    new Guid("22222222-aaaa-aaaa-aaaa-aaaaaaaaaaaa")
                });

            // Restore Alice's removed appointments with their original Jan 2026 dates.
            migrationBuilder.InsertData(
                table: "appointments",
                columns: new[] { "AppointmentId", "AppointmentDate", "AppointmentStatus", "AppointmentTime", "CreatedAt", "DocId", "EmailConfirmationSent", "PatId" },
                values: new object[,]
                {
                    {
                        new Guid("ffffffff-ffff-ffff-ffff-ffffffffffff"),
                        new DateOnly(2026, 1, 15),
                        "Confirmed",
                        new TimeOnly(11, 0, 0),
                        new DateTime(2026, 1, 1, 12, 0, 0, DateTimeKind.Utc),
                        new Guid("11111111-1111-1111-1111-111111111111"),
                        false,
                        new Guid("44444444-4444-4444-4444-444444444444")
                    },
                    {
                        new Guid("aaaaaaaa-1111-1111-1111-111111111111"),
                        new DateOnly(2026, 1, 15),
                        "Confirmed",
                        new TimeOnly(13, 0, 0),
                        new DateTime(2026, 1, 1, 12, 0, 0, DateTimeKind.Utc),
                        new Guid("11111111-1111-1111-1111-111111111111"),
                        false,
                        new Guid("55555555-5555-5555-5555-555555555555")
                    },
                    {
                        new Guid("bbbbbbbb-1111-1111-1111-111111111111"),
                        new DateOnly(2026, 1, 15),
                        "Confirmed",
                        new TimeOnly(14, 0, 0),
                        new DateTime(2026, 1, 1, 12, 0, 0, DateTimeKind.Utc),
                        new Guid("11111111-1111-1111-1111-111111111111"),
                        false,
                        new Guid("66666666-6666-6666-6666-666666666666")
                    }
                });

            migrationBuilder.Sql(@"
                UPDATE appointments SET ""AppointmentDate"" = '2026-01-15', ""AppointmentTime"" = '09:00:00', ""AppointmentStatus"" = 'Confirmed'
                WHERE ""AppointmentId"" = 'cccccccc-cccc-cccc-cccc-cccccccccccc';

                UPDATE appointments SET ""AppointmentDate"" = '2026-01-16', ""AppointmentTime"" = '10:30:00', ""AppointmentStatus"" = 'Completed'
                WHERE ""AppointmentId"" = 'dddddddd-dddd-dddd-dddd-dddddddddddd';

                UPDATE appointments SET ""AppointmentDate"" = '2026-01-15', ""AppointmentTime"" = '10:00:00'
                WHERE ""AppointmentId"" = 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee';
            ");
        }
    }
}
