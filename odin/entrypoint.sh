#!/bin/sh
set -eu

MODEL="sam860/LFM2:2.6b"

ollama serve &
OLLAMA_PID=$!

trap 'kill $OLLAMA_PID' INT TERM

until ollama list >/dev/null 2>&1; do
  sleep 1
done

if ! ollama show "$MODEL" >/dev/null 2>&1; then
  ollama pull "$MODEL"
fi

wait $OLLAMA_PID