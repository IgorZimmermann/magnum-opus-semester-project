# Saga - PDF Generation

PDF generation service that takes prescription data as input and returns a generated PDF as a binary file.

---

## Tech Stack

- **Language/Framework:** TypeScript / Hono
- **Key libraries:** Typst

---

## Running with Docker

```bash
docker-compose up saga
```

---

## Endpoints / API

| Method | Path       | Description                                      |
|--------|------------|--------------------------------------------------|
| GET    | /ping      | Health check. Returns `pong` as plain text.      |
| POST   | /generate  | Generates a PDF and returns it as a binary file buffer. |

---

**Request body** (`application/json`):

| Field                 | Type   | Required |
|-----------------------|--------|----------|
| `doctor.name`         | string | Yes      |
| `doctor.id`           | number | Yes      |
| `patient.name`        | string | Yes      |
| `patient.id`          | number | Yes      |
| `diagnosis`           | string | Yes      |
| `description`         | string | Yes      |
| `advice_prescription` | string | Yes      |

**Responses:**

- `200` — `application/pdf` binary
- `500` — `{ "message": string }`