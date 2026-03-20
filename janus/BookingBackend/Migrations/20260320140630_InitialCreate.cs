using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace BookingBackend.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Doctors",
                columns: table => new
                {
                    DocId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Doctors", x => x.DocId);
                });

            migrationBuilder.CreateTable(
                name: "Patients",
                columns: table => new
                {
                    PatId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Patients", x => x.PatId);
                });

            migrationBuilder.CreateTable(
                name: "WorksOn",
                columns: table => new
                {
                    DocId = table.Column<int>(type: "integer", nullable: false),
                    DayOfTheWeek = table.Column<int>(type: "integer", nullable: false),
                    StartsFrom = table.Column<TimeOnly>(type: "time without time zone", nullable: false),
                    EndsAt = table.Column<TimeOnly>(type: "time without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WorksOn", x => new { x.DocId, x.DayOfTheWeek });
                    table.ForeignKey(
                        name: "FK_WorksOn_Doctors_DocId",
                        column: x => x.DocId,
                        principalTable: "Doctors",
                        principalColumn: "DocId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Appointments",
                columns: table => new
                {
                    AppointmentId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DocId = table.Column<int>(type: "integer", nullable: false),
                    PatId = table.Column<int>(type: "integer", nullable: false),
                    AppointmentDate = table.Column<DateOnly>(type: "date", nullable: false),
                    AppointmentTime = table.Column<TimeOnly>(type: "time without time zone", nullable: false),
                    EmailConfirmationSent = table.Column<bool>(type: "boolean", nullable: false),
                    EmailSentAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Status = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Appointments", x => x.AppointmentId);
                    table.ForeignKey(
                        name: "FK_Appointments_Doctors_DocId",
                        column: x => x.DocId,
                        principalTable: "Doctors",
                        principalColumn: "DocId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Appointments_Patients_PatId",
                        column: x => x.PatId,
                        principalTable: "Patients",
                        principalColumn: "PatId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_DocId_AppointmentDate_AppointmentTime",
                table: "Appointments",
                columns: new[] { "DocId", "AppointmentDate", "AppointmentTime" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_PatId",
                table: "Appointments",
                column: "PatId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Appointments");

            migrationBuilder.DropTable(
                name: "WorksOn");

            migrationBuilder.DropTable(
                name: "Patients");

            migrationBuilder.DropTable(
                name: "Doctors");
        }
    }
}
