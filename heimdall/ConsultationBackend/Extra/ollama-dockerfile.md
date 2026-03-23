This was needed for LLM to work during my dev in heimdell in odin/

FROM ollama/ollama

ENV OLLAMA_MODEL=sam860/LFM2:2.6b

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


and this wasneeded in odin/ as entrypoint.sh for dockerfile
#!/bin/bash

ollama serve &
SERVER_PID=$!

echo "Waiting for Ollama to start..."
until ollama list > /dev/null 2>&1; do
  sleep 1
done

echo "Pulling model: $OLLAMA_MODEL"
ollama pull "$OLLAMA_MODEL"

echo "Model ready."
wait $SERVER_PID
