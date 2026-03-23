# ODIN - LLM

## How to start container

The container runs a custom image built from `odin/Dockerfile`.

The Ollama API is available on port `11434`. Docker maps host port `11434` to container port `11434`.

The volume `ollama_data` is mounted to `/root/.ollama/` for downloaded models to persist.

The container is started with:

```bash
docker compose up -d
```

On startup, the entrypoint automatically checks whether the required model `sam860/LFM2:2.6b` is present and pulls it if missing:

Because `/root/.ollama` is mounted to the `ollama_data` volume, the model is persisted and only needs to be pulled once.

## How to add to a `docker-compose`

```yaml
services:
  ollama:
    build:
      context: ./odin
      dockerfile: Dockerfile
    volumes:
      - ollama_data:/root/.ollama
    ports:
      - "11434:11434"

volumes:
  ollama_data:
```

## Endpoints/Interface

The interface is the **HTTP JSON API** that is exposed through Ollama.

The primary endpoint is `POST /api/chat`, which accepts a JSON request body containing the model and input messages and returns the generated response.

JSON example below:

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
