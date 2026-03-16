# ODIN - LLM

## How to start container

The container runs the `ollama/ollama` image.

The Ollama API is available on port `11434`. Docker maps host port `11434` to container port `11434`.

The volume `ollama_data` is mounted to `/root/.ollama/` for downloaded models to persist.

The container is started with:

```bash
docker compose up -d
```

After the container is running, the required model is pulled with:

```bash
docker compose exec <service_name> ollama pull sam860/LFM2:2.6b
```

`<service_name>` would need to be replaced with the Docker Compose service name.

## How to add to a `docker-compose`

```yaml
services:
  ollama:
    image: ollama/ollama
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
