using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BookingBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class LowercaseTableNames : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Drop the uppercase duplicates created by UpdateGuids.
            // The lowercase versions already exist from the consultation backend.
            migrationBuilder.Sql("DROP TABLE IF EXISTS \"Appointments\" CASCADE;");
            migrationBuilder.Sql("DROP TABLE IF EXISTS \"WorksOn\" CASCADE;");
            migrationBuilder.Sql("DROP TABLE IF EXISTS \"Doctors\" CASCADE;");
            migrationBuilder.Sql("DROP TABLE IF EXISTS \"Patients\" CASCADE;");

            // Create workson (only booking-backend table, not created by consultation backend)
            migrationBuilder.CreateTable(
                name: "workson",
                columns: table => new
                {
                    DocId = table.Column<Guid>(type: "uuid", nullable: false),
                    DayOfTheWeek = table.Column<int>(type: "integer", nullable: false),
                    StartsFrom = table.Column<TimeOnly>(type: "time without time zone", nullable: false),
                    EndsAt = table.Column<TimeOnly>(type: "time without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_workson", x => new { x.DocId, x.DayOfTheWeek });
                    table.ForeignKey(
                        name: "FK_workson_doctors_DocId",
                        column: x => x.DocId,
                        principalTable: "doctors",
                        principalColumn: "DocId",
                        onDelete: ReferentialAction.Cascade);
                });

            // Add unique constraint on appointments if it doesn't already exist
            migrationBuilder.Sql(@"
                DO $$
                BEGIN
                    IF NOT EXISTS (
                        SELECT 1 FROM pg_indexes
                        WHERE tablename = 'appointments'
                        AND indexname = 'IX_appointments_DocId_AppointmentDate_AppointmentTime'
                    ) THEN
                        CREATE UNIQUE INDEX ""IX_appointments_DocId_AppointmentDate_AppointmentTime""
                        ON appointments (""DocId"", ""AppointmentDate"", ""AppointmentTime"");
                    END IF;
                END $$;
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(name: "workson");

            migrationBuilder.Sql(@"DROP INDEX IF EXISTS ""IX_appointments_DocId_AppointmentDate_AppointmentTime"";");
        }
    }
}
