using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ConsultationBackend.Data.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";");

            migrationBuilder.CreateTable(
                name: "doctors",
                columns: table => new
                {
                    DocId = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "gen_random_uuid()"),
                    Name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    Email = table.Column<string>(type: "character varying(320)", maxLength: 320, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_doctors", x => x.DocId);
                });

            migrationBuilder.CreateTable(
                name: "patients",
                columns: table => new
                {
                    PatId = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "gen_random_uuid()"),
                    Name = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: false),
                    Email = table.Column<string>(type: "character varying(320)", maxLength: 320, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_patients", x => x.PatId);
                });

            migrationBuilder.CreateTable(
                name: "appointments",
                columns: table => new
                {
                    AppointmentId = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "gen_random_uuid()"),
                    DocId = table.Column<Guid>(type: "uuid", nullable: false),
                    PatId = table.Column<Guid>(type: "uuid", nullable: false),
                    AppointmentDate = table.Column<DateOnly>(type: "date", nullable: false),
                    AppointmentTime = table.Column<TimeOnly>(type: "time without time zone", nullable: false),
                    EmailConfirmationSent = table.Column<bool>(type: "boolean", nullable: false, defaultValue: false),
                    EmailSentAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    AppointmentStatus = table.Column<string>(type: "character varying(32)", maxLength: 32, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_appointments", x => x.AppointmentId);
                    table.ForeignKey(
                        name: "FK_appointments_doctors_DocId",
                        column: x => x.DocId,
                        principalTable: "doctors",
                        principalColumn: "DocId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_appointments_patients_PatId",
                        column: x => x.PatId,
                        principalTable: "patients",
                        principalColumn: "PatId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "doctors",
                columns: new[] { "DocId", "Email", "Name" },
                values: new object[,]
                {
                    { new Guid("11111111-1111-1111-1111-111111111111"), "alice.carter@example.com", "Dr. Alice Carter" },
                    { new Guid("22222222-2222-2222-2222-222222222222"), "ben.ortiz@example.com", "Dr. Ben Ortiz" }
                });

            migrationBuilder.InsertData(
                table: "patients",
                columns: new[] { "PatId", "Email", "Name" },
                values: new object[,]
                {
                    { new Guid("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"), "john.doe@example.com", "John Doe" },
                    { new Guid("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"), "jane.smith@example.com", "Jane Smith" }
                });

            migrationBuilder.InsertData(
                table: "appointments",
                columns: new[] { "AppointmentId", "AppointmentDate", "AppointmentStatus", "AppointmentTime", "CreatedAt", "DocId", "EmailSentAt", "PatId" },
                values: new object[] { new Guid("cccccccc-cccc-cccc-cccc-cccccccccccc"), new DateOnly(2026, 1, 15), "Confirmed", new TimeOnly(9, 0, 0), new DateTime(2026, 1, 1, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("11111111-1111-1111-1111-111111111111"), null, new Guid("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa") });

            migrationBuilder.InsertData(
                table: "appointments",
                columns: new[] { "AppointmentId", "AppointmentDate", "AppointmentStatus", "AppointmentTime", "CreatedAt", "DocId", "EmailConfirmationSent", "EmailSentAt", "PatId" },
                values: new object[] { new Guid("dddddddd-dddd-dddd-dddd-dddddddddddd"), new DateOnly(2026, 1, 16), "Completed", new TimeOnly(10, 30, 0), new DateTime(2026, 1, 5, 12, 0, 0, 0, DateTimeKind.Utc), new Guid("22222222-2222-2222-2222-222222222222"), true, new DateTime(2026, 1, 10, 8, 0, 0, 0, DateTimeKind.Utc), new Guid("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb") });

            migrationBuilder.CreateIndex(
                name: "IX_appointments_AppointmentDate_AppointmentTime",
                table: "appointments",
                columns: new[] { "AppointmentDate", "AppointmentTime" });

            migrationBuilder.CreateIndex(
                name: "IX_appointments_DocId",
                table: "appointments",
                column: "DocId");

            migrationBuilder.CreateIndex(
                name: "IX_appointments_PatId",
                table: "appointments",
                column: "PatId");

            migrationBuilder.CreateIndex(
                name: "IX_doctors_Email",
                table: "doctors",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_patients_Email",
                table: "patients",
                column: "Email",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "appointments");

            migrationBuilder.DropTable(
                name: "doctors");

            migrationBuilder.DropTable(
                name: "patients");
        }
    }
}
