# ODIN - LLM

LLM service running Ollama with a LFM2 model, exposed as an HTTP JSON API for use by other services.

---

## Tech Stack

- **Image:** Ollama 
- **Model:** sam860/LFM2:2.6b

---

## Running with Docker

```bash
docker-compose up odin
```

Ollama in mounted to `ollama_data` thus downloaded models will persist across restarts. 
---

## Endpoints / API

The API is exposed through Ollama on port `11434`.

| Method | Path       | Description                                      |
|--------|------------|--------------------------------------------------|
| POST   | /api/chat  | Send messages to the model and get a response    |

**Request body example:**

```json
{
  "model": "sam860/LFM2:2.6b",
  "format": "json",
  "messages": [
    {
      "role": "user",
      "content": "Here is the transcript: ... Generate a summary."
    }
  ]
}
```