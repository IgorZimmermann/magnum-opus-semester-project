import { useRef, useCallback } from "react";

// ─── WAV encoding ─────────────────────────────────────────────────────────────

/**
 * Encodes an AudioBuffer as a WAV ArrayBuffer (PCM 16-bit, interleaved).
 */
function encodeWav(audioBuffer: AudioBuffer): ArrayBuffer {
  const numChannels = audioBuffer.numberOfChannels;
  const sampleRate = audioBuffer.sampleRate;
  const numFrames = audioBuffer.length;
  const bytesPerSample = 2; // 16-bit PCM
  const blockAlign = numChannels * bytesPerSample;
  const byteRate = sampleRate * blockAlign;
  const dataSize = numFrames * blockAlign;
  const bufferSize = 44 + dataSize;

  const buffer = new ArrayBuffer(bufferSize);
  const view = new DataView(buffer);

  // ── RIFF chunk ──
  writeString(view, 0, "RIFF");
  view.setUint32(4, 36 + dataSize, true);
  writeString(view, 8, "WAVE");

  // ── fmt sub-chunk ──
  writeString(view, 12, "fmt ");
  view.setUint32(16, 16, true);          // sub-chunk size
  view.setUint16(20, 1, true);           // PCM = 1
  view.setUint16(22, numChannels, true);
  view.setUint32(24, sampleRate, true);
  view.setUint32(28, byteRate, true);
  view.setUint16(32, blockAlign, true);
  view.setUint16(34, 16, true);          // bits per sample

  // ── data sub-chunk ──
  writeString(view, 36, "data");
  view.setUint32(40, dataSize, true);

  // ── interleaved PCM samples ──
  const channels = Array.from({ length: numChannels }, (_, i) =>
    audioBuffer.getChannelData(i)
  );
  let offset = 44;
  for (let frame = 0; frame < numFrames; frame++) {
    for (let ch = 0; ch < numChannels; ch++) {
      const sample = Math.max(-1, Math.min(1, channels[ch][frame]));
      // convert float32 → int16
      view.setInt16(offset, sample < 0 ? sample * 0x8000 : sample * 0x7fff, true);
      offset += 2;
    }
  }

  return buffer;
}

function writeString(view: DataView, offset: number, value: string) {
  for (let i = 0; i < value.length; i++) {
    view.setUint8(offset + i, value.charCodeAt(i));
  }
}

// ─── hook ─────────────────────────────────────────────────────────────────────

export interface UseAudioRecorderReturn {
  /** Request mic access and begin recording. Throws if permission is denied. */
  start: () => Promise<void>;
  /** Stop recording and return the audio as a WAV Blob. */
  finish: () => Promise<Blob>;
}

export function useAudioRecorder(): UseAudioRecorderReturn {
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const chunksRef = useRef<Blob[]>([]);
  const streamRef = useRef<MediaStream | null>(null);
  const mimeTypeRef = useRef<string>("");

  const start = useCallback(async () => {
    // Tear down any previous session
    streamRef.current?.getTracks().forEach((t) => t.stop());
    chunksRef.current = [];

    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    streamRef.current = stream;

    const mimeType = ["audio/webm;codecs=opus", "audio/webm", "audio/ogg"]
      .find((t) => MediaRecorder.isTypeSupported(t)) ?? "";
    mimeTypeRef.current = mimeType;

    const recorder = new MediaRecorder(stream, mimeType ? { mimeType } : undefined);
    mediaRecorderRef.current = recorder;

    recorder.ondataavailable = (e) => {
      if (e.data.size > 0) chunksRef.current.push(e.data);
    };

    recorder.start(250);
  }, []);

  const finish = useCallback((): Promise<Blob> => {
    return new Promise((resolve, reject) => {
      const recorder = mediaRecorderRef.current;
      if (!recorder || recorder.state === "inactive") {
        return reject(new Error("No active recording. Call start() first."));
      }

      recorder.onstop = async () => {
        streamRef.current?.getTracks().forEach((t) => t.stop());
        streamRef.current = null;

        try {
          const blob = new Blob(chunksRef.current, {
            type: mimeTypeRef.current || "audio/webm",
          });
          const encoded = await blob.arrayBuffer();

          // Decode compressed audio → PCM float32 via Web Audio API
          const audioCtx = new AudioContext();
          const audioBuffer = await audioCtx.decodeAudioData(encoded);
          await audioCtx.close();

          resolve(new Blob([encodeWav(audioBuffer)], { type: "audio/wav" }));
        } catch (err) {
          reject(err);
        }
      };

      recorder.stop();
    });
  }, []);

  return { start, finish };
}
