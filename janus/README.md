# Janus - Booking Backend

Backend API for managing doctor availability and patient appointments, with email notifications sent on booking.

---

## Tech Stack

- **Language/Framework:** C# / ASP.NET Core (.NET 10)
- **Key libraries:** Entity Framework Core, MailKit, Auth0

---

## Running with Docker (Recommended)

```bash
docker-compose up janus
```

---

## Running Locally

```bash
cd BookingBackend
dotnet restore
dotnet run
```

Swagger UI: `http://localhost:5050/swagger/index.html`.

---

## Project Structure

```
BookingBackend/
  Controllers/      API endpoint definitions
  Services/         Business logic
  Interfaces/       Service interface
  Data/             DbContext, migrations & seeding
  Models/           ORM
  DTO/              Request and response DTOs
```

---

## Endpoints / API

**Availability** — `/api/availability`

| Method | Path                        | Description                                  |
|--------|-----------------------------|----------------------------------------------|
| GET    | /api/availability/doctors   | Returns all doctors with their weekly availability slots |

**Appointment** — `/api/appointment`

| Method | Path               | Description                                                        |
|--------|--------------------|--------------------------------------------------------------------|
| GET    | /api/appointment   | Returns all appointments in the system                             |
| POST   | /api/appointment   | Creates a new appointment and sends a confirmation email to the patient |

---

## Environment Variables

| Variable                          | Description                        | Example                |
|-----------------------------------|------------------------------------|------------------------|
| `POSTGRES_HOST`                   | PostgreSQL host                    | `magnum-postgres`      |
| `POSTGRES_PORT`                   | PostgreSQL port                    | `5432`                 |
| `POSTGRES_DB`                     | PostgreSQL database name           | `magnum`               |
| `POSTGRES_USER`                   | PostgreSQL username                | `magnum_user`          |
| `POSTGRES_PASSWORD`               | PostgreSQL password                | `changeme`             |
| `Services__Email__BaseUrl`        | Base URL of the email service      | `http://hermes:8025`   |