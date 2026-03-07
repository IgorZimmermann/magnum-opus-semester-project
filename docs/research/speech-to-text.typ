#import "../templates/research.typ": research

#show: research.with(
  topic: "Speech-to-text",
  author: "Kristóf Ákos Koltai",
)

= Researched options
- #link("https://github.com/SYSTRAN/faster-whisper")[*Faster-Whisper*]
- #link("https://developers.google.com/health-ai-developer-foundations/medasr")[MedASR]
  - #link("https://huggingface.co/google/medasr")[_(alternative huggingface link)_]
- #link("https://huggingface.co/nvidia/canary-qwen-2.5b")[NVIDIA Canary Qwen 2.5B]
- #link("https://huggingface.co/openai/whisper-large-v3")[OpenAI Whisper V3]
- #link("https://huggingface.co/nvidia/parakeet-tdt-0.6b-v3")[Parakeet TDT]

= Reason

After browsing through available models, reading through articles and doing research with the help of AI tools, I chose 5 models for deeper exploration. First I read about them, went through the pros and cons, 
researched what features each of them would offer and how well they'd align with our needs and would satisfy our requirements (all of the models mentioned below can be locally hosted and are open-source). 

Then, based on what I found, I narrowed down the
number of test subjects to the following three:

- NVIDIA Canary Qwen 2.5B
- Faster-Whisper
- MedASR

I decided to leave out OpenAI Whisper V3 and Parakeet TDT of the test because of the following reasons:
== Whisper V3:
- It's the base model of Faster-Whisper, with the added feature of speaker diarization, but it is inefficient and much slower.
== Parakeet TDT:
- Optimized for speed and not accuracy, which is unacceptable in medical environments, therefore it doesn't fulfill our requirements

#pagebreak()

The final 3 contenders would all fit into the project, but they slightly differ from each other in certain aspects: 

== NVIDIA Canary Qwen 2.5B

=== Pros

- Combines STT and language modeling in one model, meaning it can do transcription and analysis as well
- Low error rate

=== Cons/Limitations

- Large, *2.5 billion parameter* --> slower transcription
- Not specifically trained on medical data
- Would be unnecessarily complex with the added LLM feature

== MedASR

=== Pros:
- MedASR was deliberately developed for use in *medical environments and medical dictation* by Google Health AI
- It has been extensively pre-trained on medical terminologies and clinical conversations
  - Trained on actual physician - patient conversations 
- Lightweight, *105 million parameter* model
- See performance review #link("https://huggingface.co/google/medasr#performance-and-evaluations")[here]

Quote from their official website, which literally describes what we're gonna use it for:

_"MedASR allows developers to incorporate automatic speech recognition (ASR) capabilities, *specifically tuned for the medical domain* into their product. Unlike general-purpose ASR models, MedASR has been trained on extensive corpora of medical dictations. 
This makes it well-suited for: _
 - _Radiology Dictation: Accurate *transcription of imaging reports* containing complex anatomical and pathological terms._ 
 - _*Clinical Documentation*: Transcribing *physician-patient interactions* to assist in generating *clinical notes*."_

The website also mentions that it's easy to integrate with LLM's such as MedGemma.

=== Cons/Limitations

- All training data in English, therefore no multilingual support, just English (but in our use case that's not really a problem at the moment)
- No built in diarization, meaning it doesn't separate who said what natively, but in our use case speaker identification is unnecessary because it is always going to be doctor-patient conversation without multi speaker separation needs


#pagebreak()

== *Faster-Whisper*

=== Pros:

- Recommended in kick-off document
- *Multilingual*, supports many languages
- Has been around for a longer time than MedASR (which was launched in late 2025), therefore it's widely tested and proven in medical environment
- 4 times faster than original version
- *1.5 billion parameter*

=== Cons/Limitations

- Not purpose built for medical content, therefore performs much worse compared to MedASR
- Larger model size

== Testing results

I decided to focus on the two main contenders, MedASR and Faster-Whisper, and put NVIDIA Canary Qwen 2.5B a bit into the background (because the first two
allign with our needs better).

I ran several tests to see whether the tested models provide the expected results. 
I used multiple samples with different attributes:

- Short length recording made by me without any background noise (\~30 sec)
- Short length recording made by me with background noise and sound coming from multiple directions and distances (\~30 sec)
- Medium length recording made by me without any background noise (\~150 sec)
- Medium length recording made by me with background noise and sound coming from multiple directions and distances (\~150 sec)
- Long length recording of real-world medical consultation (~800 sec)

=== MedASR

The results were underwhelming especially compared to my expectations. 
At short and medium length, it performed somewhat acceptable, altough it made a significant amount of mistakes, 
which became even more apparent as the length of the recording grew. On the positive side, it was much quicker than
the competition, but that faded as the length of the recordings grew. 

I also had problems with accessing and decripting the transcriptions. When using the real-world recording, I didn't even
get anything transcribed, even tough the model worked on it for a minute and a half. I'm not sure if there was any error on my side or anything that should be done differently 
(I tried to make it work better in several ways, that was the reason for the late submission), but as of now it appears to be unreliable and inaccurate based on my testing, especially on longer real-world recordings.

=== Faster-Whisper

It performed outstandingly compared to MedASR. It had small WER (Word Error Rate) and worked at an acceptable speed.
It repeatedly transcribed recordings with barely any mistakes, regardless of length and background noise.

The test demonstrated what I read about it beforehand, that it is a proven model that has been tested and trialed in action.
It is relatively fast, has a greater number of parameters and is more reliable compared to the competitors.

=== Results

Here are some of the test results I got:

 - 30 sec sample (recorded by me):
  - Faster-Whisper - 2,05 s - rough WER: \~0,3% (one or two spelling mistake)
  - MedASR - 0,88 sec - rough WER: \~23% (words repeated, inaccurate spelling, added things)

 - 150 sec sample (recorded by me):
  - Faster-Whisper - 31,25 s - rough WER: \~2%
  - MedASR - 6,25 sec - rough WER: \~28% (lot of words repeated, inaccurate spelling)

 - 800 sec real-world sample
  - Faster-Whisper - 138 s - rough WER: \~4% (made a bit more mistakes but nothing that would cause problems)
  - MedASR - 92,5 sec - rough WER: N/A

== Conclusion

- *Faster-Whisper*: Proven, general-purpose, multilingual
- MedASR: Specialized model, built deliberetaly for medical use
- Canary Qwen: Hybrid of STT and LLM, larger model

In conclusion, based on the results of testing, we should use *Faster-Whisper*, since it had high accuracy, okay speed and it was reliable. On the other hand, I would give MedASR another go, because
based on what I read online it would fit our project better (intentionally built for medical transcription) and it seems to be much faster.

= How to get started

Check out installation section #link("https://github.com/SYSTRAN/faster-whisper?tab=readme-ov-file#installation")[here]
= Interactivity

Once the STT service processes the audio input, it sends the transcription for summarization to the LLM via the backend with a POST request.