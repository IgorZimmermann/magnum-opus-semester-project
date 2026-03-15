import tempfile
import os
from faster_whisper import WhisperModel
from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.responses import JSONResponse
from fastapi.openapi.utils import get_openapi
from pydantic import BaseModel

app = FastAPI(
    title="Audio Processing API",
    description="Transcribes audio files to text.",
    version="1.0.0",
)

#Can be changed later according to our needs
model = WhisperModel("base")

class PingResponse(BaseModel):
    message: str


class TranscriptionResponse(BaseModel):
    text: str


@app.get(
    "/ping",
    response_model=PingResponse,
    summary="Health check",
)
def ping() -> PingResponse:
    """Returns a simple pong response to confirm the service is running."""
    return PingResponse(message="pong")


@app.get(
    "/doc",
    summary="OpenAPI specification",
    include_in_schema=False,
)
def get_openapi_spec() -> JSONResponse:
    """Returns the OpenAPI 3.1 schema for this API."""
    schema = get_openapi(
        title=app.title,
        version=app.version,
        description=app.description,
        routes=app.routes,
    )
    return JSONResponse(content=schema)


@app.post(
    "/process",
    response_model=TranscriptionResponse,
    summary="Transcribe audio to text",
)
async def process_audio(
    file: UploadFile = File(..., description="Audio file to transcribe"),
) -> TranscriptionResponse:
    """
    Accepts an uploaded audio file and returns its transcription as text.

    Supported content types: audio/mpeg, audio/wav, audio/ogg, audio/webm, etc.
    """
    if not file.content_type or not file.content_type.startswith("audio/"):
        raise HTTPException(
            status_code=415,
            detail=f"Unsupported media type '{file.content_type}'. Expected an audio/* file.",
        )

    audio_bytes = await file.read()

    with tempfile.NamedTemporaryFile(delete=False, suffix=".wav") as temp:
        temp.write(audio_bytes)
        temp_path = temp.name
    try:
        segments, _ = model.transcribe(temp_path)
        segments = list(segments)
        transcribed_text = " ".join(segment.text for segment in segments)
    finally:
        os.remove(temp_path)

    return TranscriptionResponse(text=transcribed_text)
