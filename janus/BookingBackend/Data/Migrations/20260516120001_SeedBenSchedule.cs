using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814

namespace BookingBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class SeedBenSchedule : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Dr. Ben Ortiz — Mon–Sat (days 1–6), 09:00–17:00
            migrationBuilder.InsertData(
                table: "workson",
                columns: new[] { "DayOfTheWeek", "DocId", "EndsAt", "StartsFrom" },
                values: new object[,]
                {
                    { 1, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) },
                    { 2, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) },
                    { 3, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) },
                    { 4, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) },
                    { 5, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) },
                    { 6, new Guid("22222222-2222-2222-2222-222222222222"), new TimeOnly(17, 0, 0), new TimeOnly(9, 0, 0) }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 1, new Guid("22222222-2222-2222-2222-222222222222") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 2, new Guid("22222222-2222-2222-2222-222222222222") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 3, new Guid("22222222-2222-2222-2222-222222222222") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 4, new Guid("22222222-2222-2222-2222-222222222222") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 5, new Guid("22222222-2222-2222-2222-222222222222") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 6, new Guid("22222222-2222-2222-2222-222222222222") });
        }
    }
}
