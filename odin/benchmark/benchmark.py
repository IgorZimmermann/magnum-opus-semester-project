import json
import time
import requests

SYSTEM_PROMPT_SUMMARY = (
	"You are a clinical documentation assistant."
	"You are given a doctor-patient consultation transcript, extract the key clinical information."
	"Only include information that was explicitly stated in the transcript."
	"Do not guess, assume, or add anything that was not directly said by the doctor or patient."
	"Respond ONLY with a valid JSON object. No explanation, no comments, no markdown."
	"The JSON must have exactly these fields:\n"
	"symptoms: list of symptoms reported by the patient\n"
	"diagnosis: the doctor's diagnosis\n"
	"advice_and_prescription: list of advice made by the doctor and/or prescribed medicines\n"
)

SYSTEM_PROMPT_SUGGESTIONS = (
	"You are a clinical support assistant, who aids the doctors work after consultation."
	"You are given a structured consultation summary."
	"Your job is to identify clinical elements the doctor may have missed, overlooked or diagnosed wrongly."
	"Do not suggest anything that is already present in the summary, this is very important."
	"Only suggest things that were not addressed by the doctor at all."
	"Make sure that anything you suggest is relevant and needed in a real-world situation, not an edge case."
	"Respond ONLY with a valid JSON object. No explanation, no comments, no markdown."
	"The JSON must have exactly these fields:\n"
	"suggested_symptoms_to_check: symptoms that were not asked about but may be relevant clinically\n"
	"suggested_medicines: medicines that are not already prescribed that could be considered based on symptoms and diagnosis\n"
	"suggested_referrals: referrals not already made that may be appropriate\n"
)

TRANSCRIPTS = [
	("tiny",   "transcripts/transcript_tiny.txt",   "1 min"),
	("short",  "transcripts/transcript_short.txt",  "3 min"),
	("medium", "transcripts/transcript_medium.txt", "7 min"),
	("long",   "transcripts/transcript_long.txt",   "10 min"),
	("echo",   "transcripts/transcript_echo.txt",   "14 min"),
]

def load_transcript(filename):
	with open(filename, "r", encoding="utf-8") as f:
		return f.read()

def call_model(system, user):
	start = time.perf_counter()
	response = requests.post("http://localhost:11434/api/chat", json={
		"model": "sam860/LFM2:2.6b",
		"format": "json",
		"stream": False,
		"messages": [
			{"role": "system", "content": system},
			{"role": "user", "content": user},
		],
	}, timeout=300)
	elapsed = time.perf_counter() - start
	response.raise_for_status()
	return response.json()["message"]["content"], elapsed

def run_case(transcript_text):
	summary, summary_time = call_model(SYSTEM_PROMPT_SUMMARY, transcript_text)
	print(f"Summary: {summary_time:.2f}s")

	suggestions, suggestions_time = call_model(SYSTEM_PROMPT_SUGGESTIONS, summary)
	print(f"Suggestions: {suggestions_time:.2f}s")

	return {
		"summary": summary,
		"suggestions": suggestions,
		"summary_time_s": round(summary_time, 2),
		"suggestions_time_s": round(suggestions_time, 2),
	}

results = {}

for name, path, duration in TRANSCRIPTS:
	print(f"\nCase: {name} ({duration})")
	results[name] = run_case(load_transcript(path))
	results[name]["duration"] = duration

with open("benchmark_results.json", "w") as f:
	json.dump(results, f, indent=2)