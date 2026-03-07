#import "../templates/research.typ": research

#show: research.with(
  topic: "Speech-to-text",
  author: "Kristóf Ákos Koltai",
)

= Researched options
- #link("https://developers.google.com/health-ai-developer-foundations/medasr")[*MedASR*]
  - #link("https://huggingface.co/google/medasr")[_(alternative huggingface link)_]
- #link("https://github.com/SYSTRAN/faster-whisper")[Faster-Whisper]
- #link("https://huggingface.co/nvidia/canary-qwen-2.5b")[NVIDIA Canary Qwen 2.5B]
- #link("https://huggingface.co/openai/whisper-large-v3")[Google Whisper V3]
- #link("https://huggingface.co/nvidia/parakeet-tdt-0.6b-v3")[Parakeet TDT]

= Reason

After browsing through available models, reading through articles and doing research with the help of AI tools, I chose 5 models for deeper exploration. First I read about them, went through the pros and cons, 
researched what features each of them would offer and how well they'd allign with our needs and would satisfy our requirments (all of the models mentioned below can be locally hosted and are open-source). 

Then, based on what I found, I narrowed down the
number of test subjects to the following three:

- NVIDIA Canary Qwen 2.5B
- Faster-Whisper
- MedASR

I decided to leave out Google Whisper V3 and Parakeet TDT of the test because of the following reasons:
== Whisper V3:
- It's based on Faster-Whisper, with the added feature of speaker diarization, but it is inefficient and much slower.
== Parakeet TDT:
- Optimized for speed and not accuracy, which is unacceptable in medical environments, therefore it doesn't fulfill our requirements

The final 3 contenders would all fit into the project, but they slightly differ from each other in certain aspects: 

== NVIDIA Canary Qwen 2.5B

=== Pros

- Can combine STT and LLM in one model, meaning it can do transcription and analysis as well
- Low error rate

=== Cons/Limitations

- Large, *2.5 billion parameter* --> slower transcription
- Not specifically trained on medical data
- Would be unnecessarily complex with the added LLM feature


== Faster-Whisper

=== Pros:

- Recommended in kick-off document
- *Multilingual*, supports many languages
- Has been around for a longer time than MedASR (which was launched in late 2025), therefore it's widely tested and proven in medical environment
- 4 times faster than original version
- *1.5 billion parameter*

=== Cons/Limitations

- Not purpose built for medical content, therefore performs much worse compared to MedASR
- Larger model size

== *MedASR*

=== Pros:
- MedASR was deliberetaly developed for use in *medical environments and medical dictation* by Google Health AI
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
- No built in diarization, meaning it doesn't separate who said what natively, but in our use case speaker identification is unnecessary because it is always going to be doctor-patient conversation without multi speakar separation needs

== Testing results

 _will be added_

== Conclusion

- *MedASR*: Specialized model, built deliberetaly for medical use
- Faster-Whisper: Proven general-purpose, multilingual
- Canary Qwen: Hybrid of STT and LLM, larger model

In my opinion *MedASR* fits our project the best, since it is designed for this exact use case.

= How to get started

Check out the how to use section #link("https://huggingface.co/google/medasr#how-to-use")[here]
= Interactivity

Once the STT service processes the audio input, it sends the transcription for summarization to the LLM via the backend with a POST request.