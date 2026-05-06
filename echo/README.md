# ECHO - Speech-to-Text

Speech-to-text service that runs faster-whisper from a Python script. Takes audio as input and transcribes it as text as output.

---

## Tech Stack

- **Language/Framework:** Python, Docker
- **Key libraries:** faster_whisper, fastapi

---

## Running with Docker 

```bash
docker-compose up echo
```

---

## Project Structure

```
src/
  main.py         contains Python script that pulls the faster_whisper model
requirements.txt  model config file
```

---

## Endpoints / API

| Method | Path     | Description                                                              |
|--------|----------|--------------------------------------------------------------------------|
| GET    | /ping    | Health check. Returns `pong` as plain text.                              |
| GET    | /doc     | Returns the OpenAPI specification.                                       |
| POST   | /process | Transcribes an audio file and returns the transcription as text.         |

---

**Request body** (`multipart/form-data`):

| Field  | Type       | Required |
|--------|------------|----------|
| `file` | audio file | Yes      |

**Supported formats:** anything labeled `audio/*` (mp3, wav, m4a, aac, etc.)

**Responses:**

- `200` - `application/json` - `{ "text": string }`
- `415` - `application/json` - `{ "detail": string }` - (Unsupported media type (e.g.: pdf))
