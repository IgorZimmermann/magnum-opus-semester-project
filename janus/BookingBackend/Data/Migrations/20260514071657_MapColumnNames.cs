using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BookingBackend.Data.Migrations
{
    /// <inheritdoc />
    public partial class MapColumnNames : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Only rename if the old column name still exists (fresh DB from UpdateGuids used "Status")
            migrationBuilder.Sql(@"
                DO $$
                BEGIN
                    IF EXISTS (
                        SELECT 1 FROM information_schema.columns
                        WHERE table_name = 'appointments' AND column_name = 'Status'
                    ) THEN
                        ALTER TABLE appointments RENAME COLUMN ""Status"" TO ""AppointmentStatus"";
                    END IF;
                END $$;
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "AppointmentStatus",
                table: "appointments",
                newName: "Status");
        }
    }
}
