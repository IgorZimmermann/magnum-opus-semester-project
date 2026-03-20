# ConsultationBackend

ASP.NET Core 9 backend for the AI-powered medical consultation workflow. It handles workflow from starting the consulations, to transcriptions, to generating summaries and to finally creating a doctors note.

---

## Quick Start

### 1. Start services

```bash
docker compose up -d
```


### 2. Configure environment

Copy `.env.example` to `.env` and adjust if needed:

```bash
cp .env.example .env
```

Default values in `.env.example` match `appsettings.json` for local development (change if you need).

### 3. Run the backend

```bash
dotnet run
```

The API will be available at `http://localhost:5096` by default

Swagger UI: `http://localhost:5096/swagger`

Migrations and seeding run automatically on startup

---

## Project Structure

```
ConsultationBackend/
├── Controllers/          # HTTP endpoints / routes
├── Data/
│   ├── AppDbContext.cs   # EF Core context (PostgreSQL)
│   ├── MongoDbContext.cs # MongoDB collections
│   ├── Migrations/       # EF Core migrations
│   └── Seed/
│       └── StartupSeeder.cs  # MongoDB seed data
├── Dtos/
│   ├── Requests/         # Incoming request Dto
│   └── Responses/        # Outgoing response Dto
├── Infrastructure/       # HTTP clients wrapping external services
│   ├── LLM.cs            # Ollama LLM calls
│   ├── SpeechToText.cs   # Faster-Whisper transcription
│   ├── Pdf.cs            # PDF generator calls
│   └── Email.cs          # Mailpit calls
├── Interfaces/           # Service + infrastructure contracts
├── Models/
│   ├── Relational/       # EF Core entities
│   └── NonRelational/    # MongoDB documents 
├── Services/             # Business logic
├── Extra/                # Files needed for development
├── Properties/
│   └── launchSettings.json
├── appsettings.json
├── appsettings.Development.json
├── .env.example
├── Dockerfile
└── Program.cs
```

---

## Port / URL Configuration


`appsettings.json` holds the **local development** URLs thus these must match with the dockerfile.

---

## API Endpoints

### Consultation
| Method | Route | Description |
|---|---|---|
| `POST` | `/api/consultation/startConsultation` | Start a consultation from a confirmed appointment |
| `GET` | `/api/consultation/GetConsultation` | Get consultation details |

### Transcript
| Method | Route | Description |
|---|---|---|
| `POST` | `/api/transcript/GenerateTranscript` | Upload a `.wav` file to generate a transcript |
| `GET` | `/api/transcript/GetTranscript` | Get the generated transcript |

### Summary
| Method | Route | Description |
|---|---|---|
| `POST` | `/api/summary/GenerateSummary` | Generate an AI clinical summary from the transcript |
| `GET` | `/api/summary/GetSummary` | Get the summary (returns approved version if available) |
| `PUT` | `/api/summary/EditSumamry` | Edit and approve the summary |

### Prescription
| Method | Route | Description |
|---|---|---|
| `POST` | `/api/prescription/GeneratePrescription` | Generate a doctor's note from the summary |
| `GET` | `/api/prescription/GetPrescription` | Get the doctor's note |
| `PUT` | `/api/prescription/EditPrescription` | Edit the doctor's note |
| `POST` | `/api/prescription/ApprovePrescription` | Approve — generates PDF and emails to patient |


