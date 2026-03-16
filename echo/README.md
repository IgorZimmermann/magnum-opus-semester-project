# ECHO - Speech-to-text

## How to start container

The container requires only a port expose to work. The internal port is 3000, map that to any desired port.

```
docker build -t echo .
docker run -p 3000:3000 --name echo echo
```
## How to try it out

If you want to test how the transcription works, do the following:
1. Open browser, go to `http://localhost:3000/ping` to check if container is running
1. Add an audio recording to the echo folder wav format
1. Name it test.wav
1. Send a POST request with an audio file with the following:
    ```
    curl.exe -X POST http://localhost:3000/process -F "file=@test.wav;type=audio/wav"
    ```


## How to add to a `docker-compose`
```yaml
services:
  echo:
    build: .
    ports:
      - "3000:3000"
```

## Endpoints/Interface

## `GET /ping`

Health check. Returns `pong` as plain text.

## `GET /doc`

Returns the OpenAPI specification.

## `POST /process`

Transcribes an audio file and returns the transcription as text.

**Request body** (`multipart/form-data`):

| Field | Type | Required |
|---|---|---|
| `file` | audio file | Yes |

**Supported formats:** anything labeled `audio/*` (mp3, wav, m4a, aac, etc.)

**Responses:**

- `200` - `application/json` - `{ "text": string }`
- `415` - `application/json` - `{ "detail": string }` - (Unsupported media type (e.g.: pdf))