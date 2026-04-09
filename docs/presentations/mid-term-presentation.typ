#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus Clinic",
  members: json("../team-members.json"),
)





#slide(title: "Problem statement")[
  #align(center + horizon)[
    Danish General Practitioners (GPs) have contact with around 49 patients per day on average. Operating with such a high volume of patients carries risks of making mistakes across three core steps: diagnosis, prescribing, and referral.

    #text(size: 10pt)[Source: Beskrivelse af almen praksissektoren i Danmark (2016)]
  ]
]

//https://www.ism.dk/Media/D/4/03-Beskrivelse-af-almen-praksis.pdf page 15
#slide(title: "Project's goal")[
  #align(center + horizon)[
    The goal of this year's semester project is to identify potential mistakes during the consultation made by GPs by providing an AI-assisted workflow, where both the medical AI and the GP can look for mistakes made during the consultation.
  ]
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

#slide(title: "Proposed Solution")[
  - Locally hosted OPD management system for workflow automation
  - Isolated services, component-based architecture
  - Privacy-first approach
]

#slide(title: "Core Features")[
  - Appointment booking
  - Speech-To-Text //Transcription via Faster-Whisper
  - LLM summarisation //Conversion of consultation transcript to comprehensive summary
  - Prescription generation //Structured doctor's note (explain what it includes)
  - LLM suggestions //Provides a safety-net, checks for mistakes
  - Prescription review //The doctor can edit and review, they get the final say!!
  - PDF generation, email sending
]

#slide(title: "System Workflow - Login")[
  #align(center + horizon)[
    #image("../images/ActivityLogin.drawio.svg", width: 100%, height: 120%, fit: "contain")
  ]
]

#slide(title: "System Workflow - Booking")[
  #align(center + horizon)[
    #image("../images/ActivityBooking.drawio.svg", width: 100%, height: 120%, fit: "contain")
  ]
]

#slide(title: "System Workflow - Consultation")[
  #align(center + horizon)[
    #image("../images/ActivityDoctor.drawio.svg", width: 100%, height: 120%, fit: "contain")
  ]
]

#slide(title: "Implied Tech Stack")[
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

#slide(title: "System Architecture")[
  #align(center + horizon)[
    #image("../images/CBSE2.drawio.svg", width: 100%, height: 105%, fit: "contain")
  ]
]

// Slide: Database Schema
// Talking points: (~20 seconds)
//  - Quick look at the relational database schema.
//  - PostgreSQL stores all structured data: users, doctors, and bookings.
//  - The non-relational side (MongoDB) handles unstructured data like
//    transcripts, AI summaries, suggestions, and generated prescriptions.

#slide(title: "Database Schema")[
  #align(center + horizon)[
    #image("../images/relational_database.drawio.svg", width: 100%)
  ]
]

// Slide: Class Structure (OPTIONAL — ~15 seconds if time allows)

#slide(title: "Class Structure")[
  #align(center + horizon)[
    #image("../images/UML.drawio.svg", width: 100%)
  ]
]

// Slide: Current Status

#slide(title: "Current Status")[
  - Both backends fully functional (booking + consultation)
  - All 4 infrastructure services running (STT, LLM, PDF, Email)
  - Both databases up (PostgreSQL + MongoDB)
  - Cleaning up & aligning both backends
  - Updating diagrams to match the implementation
  - Implementing authentication & authorisation
]

// Slide: Challenges / Blockers

#slide(title: "Challenges / Blockers")[
  - Coming up with a working component-based system design
  - Model parameter size limitations, due to low performance hardware
  - Broad project scope/specification
]

// Slide: Left to Do

#slide(title: "Left to Do")[
  - Build patient portal frontend (Next.js)
  - Build doctor portal frontend (Next.js)
  - Unit tests and functional tests (target: ≥ 80% coverage)
]

#slide(title: "Left to Do")[
  #align(center + horizon)[
    #image("../images/frontend_wireframe.jpg", width: 100%, fit: "contain")
  ]
]

// Slide: Extra (If We Have Time)

#slide(title: "Extra (If We Have Time)")[
  - Stress testing & edge case testing
  - Benchmark testing (comparing LLM model performance)
  - Switchable LLM models / try alternative models
  - Diagnostic image upload during consultations
]

// Slide: Conclusion, Wrap-up

#slide(title: "Wrapping up")[
  - Our team made great progress
  - We have a thought-out roadmap
  - We believe our software will be a great help for doctors
]
