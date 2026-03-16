# Saga - PDF Generation

## How to start container

The container requires only a port expose to work. The internal port is 3000, map that to any desired port.

## How to add to a `docker-compose`

```yaml
services:
  api:
    build: .
    ports:
      - "3000:3000"
```

## Endpoints/Interface

## `GET /ping`

Health check. Returns `pong` as plain text.

## `POST /generate`

Generates a PDF and returns it as a binary file buffer.

**Request body** (`application/json`):

| Field | Type | Required |
|---|---|---|
| `doctor.name` | string | ✓ |
| `doctor.id` | number | ✓ |
| `patient.name` | string | ✓ |
| `patient.id` | number | ✓ |
| `diagnosis` | string | ✓ |
| `description` | string | ✓ |
| `advice_prescription` | string | ✓ |

**Responses:**

- `200` — `application/pdf` binary
- `500` — `{ "message": string }`
