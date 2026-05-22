using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace BookingBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class SeedAliceSchedule : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "workson",
                columns: new[] { "DayOfTheWeek", "DocId", "EndsAt", "StartsFrom" },
                values: new object[,]
                {
                    { 0, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 1, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 2, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 3, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 4, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 5, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) },
                    { 6, new Guid("11111111-1111-1111-1111-111111111111"), new TimeOnly(23, 59, 0), new TimeOnly(0, 0, 0) }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 0, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 1, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 2, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 3, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 4, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 5, new Guid("11111111-1111-1111-1111-111111111111") });

            migrationBuilder.DeleteData(
                table: "workson",
                keyColumns: new[] { "DayOfTheWeek", "DocId" },
                keyValues: new object[] { 6, new Guid("11111111-1111-1111-1111-111111111111") });
        }
    }
}
