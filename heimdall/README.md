# Heimdall - Consultation Backend

Backend for consultation logic, uses ASP.NET Core as a RESTful API to expose its services

---

## Tech Stack

- **Language/Framework:** C# / ASP.NET Core (.NET 9)
- **Key libraries:** Entity Framework Core, MongoDB, Auth0

---

## Running with Docker 

```bash
docker-compose up heimdall
```

---

## Running Locally

```bash
cd ConsultationBackend
dotnet restore
dotnet run
```

Swagger UI: `http://localhost:5000/swagger/index.html`.

---

## Project Structure

```
ConsultationBackend/
  Controllers/      API endpoint definitions
  Services/         Business logic
  Interfaces/       Service and infrastructure interfaces
  Data/             DbContext, migrations & seeding
  Models/           ORM
  Dtos/             Request and response DTOs
  Infrastructure/   External service integrations (LLM, PDF, email, speech-to-text)
```

---

## Endpoints / API

All endpoints require a JWT Bearer token by Auth0.

**Consultation** — `/api/consultation`

| Method | Path                                    | Description                          |
|--------|-----------------------------------------|--------------------------------------|
| POST   | /api/consultation/StartConsultation     | Start a new consultation             |
| GET    | /api/consultation/GetConsultation       | Retrieve a consultation by ID        |
| GET    | /api/consultation/GetDoctorAppointments | Get all appointments for a doctor    |

**Transcript** — `/api/transcript`

| Method | Path                               | Description                              |
|--------|------------------------------------|------------------------------------------|
| POST   | /api/transcript/GenerateTranscript | Generate a transcript from an audio file |
| GET    | /api/transcript/GetTranscript      | Retrieve a transcript by consultation ID |

**Summary** — `/api/summary`

| Method | Path                          | Description                         |
|--------|-------------------------------|-------------------------------------|
| POST   | /api/summary/GenerateSummary  | Generate a summary for a consultation |
| GET    | /api/summary/GetSummary       | Retrieve a summary by consultation ID |
| PUT    | /api/summary/EditSummary      | Edit an existing summary             |

**Prescription** — `/api/prescription`

| Method | Path                                    | Description                            |
|--------|-----------------------------------------|----------------------------------------|
| POST   | /api/prescription/GeneratePrescription  | Generate a prescription                |
| GET    | /api/prescription/GetPrescription       | Retrieve a prescription by consultation ID |
| PUT    | /api/prescription/EditPrescription      | Edit an existing prescription          |
| POST   | /api/prescription/ApprovePrescription   | Approve a prescription                 |

---

## Environment Variables

| Variable              | Description                       | Example        |
|-----------------------|-----------------------------------|----------------|
| `POSTGRES_DB`         | PostgreSQL database name          | `consultationdb` |
| `POSTGRES_USER`       | PostgreSQL username               | `postgres`     |
| `POSTGRES_PASSWORD`   | PostgreSQL password               | `postgres`     |
| `POSTGRES_PORT`       | PostgreSQL port                   | `5432`         |
| `MONGO_DB`            | MongoDB database name             | `consultationdocs` |
| `MONGO_ROOT_USERNAME` | MongoDB root username             | `root`         |
| `MONGO_ROOT_PASSWORD` | MongoDB root password             | `example`      |
| `MONGO_PORT`          | MongoDB port                      | `27017`        |