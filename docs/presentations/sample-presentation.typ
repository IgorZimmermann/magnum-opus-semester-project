#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus Clinic",
  members: json("../team-members.json"),
)

#slide(title: "Why We Built This")[
  #align(center + horizon)[
    Outdated systems. Manual paperwork. Fragmented tools. GPs are spending more time on *administration* than on *patients*.

    #v(1em)

    *10–20 hours per week* lost to admin tasks alone \
    Staff burnout, longer wait times, shorter consultations \
    Most of the commercial alternatives require cloud infrastructure
    #v(1em)

    #text(size: 13pt, style: "italic")[
      There is a clear need for a simple, local, open-source solution.
    ]
  ]
]

#slide(title: "Problem statement")[
  #align(center + horizon)[
    Danish General Practitioners (GPs) have contact with around 49 patients per day on average. Operating with such a high volume of patients carries risks of making mistakes across three core steps: diagnosis, prescribing, and referrals.

    #text(size: 10pt)[Source: Beskrivelse af almen praksissektoren i Danmark (2016)]
  ]
]
//https://www.ism.dk/Media/D/4/03-Beskrivelse-af-almen-praksis.pdf page 15
#slide(title: "Project's goal")[
  #align(center + horizon)[
    Our semester's project's goal is to build a software solution to identify potential mistakes during the consultation made by GPs by providing an AI-assisted workflow, where both the medical AI and the GP can look for mistakes made during the consultation.
  ]
]

#slide(title: "Proposed Solution")[
  *Our answer:*
  - Locally hosted, AI-assisted OPD management system
  - Privacy-first — patient data never leaves the clinic
  - Component-based architecture — every service independently replaceable
]

#slide(title: "What The System Does")[
  *Consultation worfklow:*
  - Record consultations via the doctor portal
  - Automatic speech-to-text transcription (Faster-Whisper)
  - AI-generated consultation summary (local LLM via Ollama)
  - AI suggestions — flags overlooked medications or referrals
  - Review, edit, and approve the final prescription
  - Export prescription as PDF and send directly to patient by email \

  *PoC - Booking worfklow*:
  - Book new appointments with doctors
  - Manage current booked appointments


]

#slide(title: "Tech Stack")[
  *Frontend*
  - Next.js + TypeScript — patient portal (Iris) & doctor portal (Eir)

  *Backend*
  - ASP.NET — booking service (Janus) & consultation service (Heimdall)

  *AI Services*
  - Faster-Whisper — speech-to-text (Echo)
  - Ollama + local LLM — summarisation & suggestions (Odin)

  *Supporting Services*
  - Typst — PDF generation (Saga)
  - Mailpit — email delivery (Hermes)

  *Data*
  - PostgreSQL — structured data & MongoDB — unstructured data
]

// Slide: Implied Tech Stack
// Talking points:
//  - This is the application layer diagram — gives a high-level overview of
//    the system and how all the pieces interact with each other.
//  - We follow a service-oriented and component-based architecture.
//  - Two separate backend systems: one for the booking system and one for the
//    consultation workflow. They share the same databases.
//  - Walk through the layers top to bottom:
//      Frontend  — Next.js / TypeScript (patient portal + doctor portal)
//      Backend   — FastAPI (booking service + clinical workflow service)
//      Services  — Faster-Whisper, Ollama + LLM, Typst (PDF), Mailpit (email)
//      Data      — PostgreSQL (structured) + MongoDB (unstructured)
//  - Everything is run with Docker Compose.
//      Each service is its own isolated container and they talk via REST API.
//      The backends loosely follow the OpenAPI spec and expose a SwaggerUI.

#slide(title: "Application Diagram")[
  #align(center + horizon)[
    #image("../images/ApplicationDiagram.jpg", width: 100%, height: 105%, fit: "contain")
  ]
]


// Slide: System Architecture — Component Diagram
// Talking points:
//  - This is the component-based system diagram.
//  - Services communicate only through clearly defined interfaces — this gives
//    us clean contracts between components (dependency injection style).
//  - The two backends are fully independent — the booking system has no access
//    to consultation data, which is key for our privacy-first design.
//  - Because of this modularity, individual components can be swapped out
//    without touching anything else.

#slide(title: "Component Based Diagram")[
  #align(center + horizon)[
    #image("../images/CBSE2.drawio.svg", width: 100%, height: 105%, fit: "contain")
  ]
]

#slide(title: "")[
  #align(center + horizon)[
    #image("/assets/image.png")
    #image("/assets/image-1.png")
  ]
]

#slide(title: "")[
  #align(center + horizon)[
    #image("/assets/image-2.png")
  ]
]

#slide(title: "What We Achieved")[
  - Full consultation workflow: recording → transcription → summary → prescription → email
  - Both frontends are functional
  - Both backends fully deployed and authenticated (Auth0)
  - All 4 AI/support services running in isolated Docker containers
  - Entire system reproducible across all machines via Docker Compose
]

#slide(title: "LLM — Liquid AI vs Gemma 4")[
  *Summary Quality (ROUGE-1 / BERTScore)*
  - Liquid AI: ROUGE-1 *0.562*, BERTScore *0.385*, latency *110s*
  - Gemma 4: ROUGE-1 0.487, BERTScore 0.341, latency 267s

  *Medical Knowledge (MedQA — 50 questions)*
  - Gemma 4: *74%* accuracy — but 81s average latency
  - Liquid AI: 48% accuracy — but *15s* average latency

  #text(size: 12pt, style: "italic")[
    → Liquid AI selected: better clinical summaries and 2.4× faster
  ]
]

#slide(title: "Speech-to-Text — Stress Testing")[
  - Zero failures across all concurrency levels (1–24 simultaneous requests)
  - Throughput stable at *~0.42 req/sec* regardless of load
  - Latency scales linearly and predictably with concurrency
  - Full recovery to baseline after peak stress — no resource leaks

  #text(size: 12pt, style: "italic")[
    → Reliable for single-clinic, low-concurrency use
  ]
]

#slide(title: "Current constraints")[
  - Booking backend remains a PoC — lacks full business logic
  - Mailpit is dev-only — production needs a real SMTP service
  - STT cannot handle concurrent audio files — no horizontal scaling yet
]

#slide(title: "Future Work")[
  - LLM with patient history — flag contraindications and allergy risks
  - Doctor-rated AI responses → fine-tune local model over time
  - Async/job-queue STT for parallel audio processing
  - Pre-consultation symptom form fed into LLM context
  - Appointment reminders + past consultation history in patient portal
]

#slide(title: "Conclusion")[
  - Full end-to-end OPD system — from booking to prescription delivery
  - Privacy-preserving by design — no patient data leaves the clinic
  - Component-based architecture proven in practice — modular, testable, replaceable
  - Solid foundation for real-world deployment
]




