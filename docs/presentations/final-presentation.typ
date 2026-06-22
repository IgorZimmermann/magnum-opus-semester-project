#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus Clinic",
  members: json("../team-members.json"),
)

#slide(title: "OPD-Vertex")[
  #align(center + horizon)[
    #text(size: 18pt)[A privacy-preserving, AI-assisted outpatient consultation system]

    #v(1.5em)

    #text(size: 14pt)[Locally hosted | Open-source | Component-based]
  ]
]

#slide(title: "The Problem")[
  #align(center + horizon)[
    Danish General Practitioners (GPs) have contact with around 49 patients per day on average. Operating with such a high volume of patients carries risks of making mistakes across three core steps: diagnosis, prescribing, and referrals.

    #text(size: 10pt)[Source: Beskrivelse af almen praksissektoren i Danmark (2016)]

    #v(1.5em)

    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1em,
      align(center)[*10–20 hrs/week* \ #text(size: 11pt)[lost to admin tasks]],
      align(center)[*58%* \ #text(size: 11pt)[of diagnostic errors occur during GP consultations]],
      align(center)[*Cloud-based* \ #text(size: 11pt)[alternatives risk GDPR compliance]],
    )
  ]
]

#slide(title: "Goal and Solution")[
  #align(horizon)[
    #text(size: 18pt)[
      *Build an OPD management system that:*
      - has a secure, privacy-first design
      - automates the full consultation workflow
      - uses locally hosted open-source AI models
    ]
  ]
]

/* - This semesters project design main focus was on redundancy and fail-safe systems. This is why we choose the component based systmes framework and created two instances of the frontend, backend and database. This ensures that if one part of the system fails then the others can still keep going.
- Two backends: one relational and one document based.
- Two frontends: Contract first approach. one is for consultation doctor side, the other is proof of concept
- C# ASP:NET: layered architecture: Controllers, services, interfaces, repositories Services depend only on interfaces, never concrete implementations dependency injection lets ASP.NET wire in the right backend/database at runtime*/
#slide(title: "System design and architecture")[
  #align(center + horizon)[
    #image("../images/ApplicationDiagram.jpg", width: 100%, height: 105%, fit: "contain")
  ]
]


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

#slide(title: "½")[
  #align(center + horizon)[
    #image("../images/CBSE2.drawio.svg", width: 100%, height: 105%, fit: "contain")
  ]
]



#slide(title: "Patient Workflow")[
  #align(center + horizon)[
    #image("../images/ActivityBooking.drawio.svg", width: 100%, height: 165%, fit: "contain")
  ]
]

#slide(title: "Doctor Workflow")[
  #align(center + horizon)[
    #image("../images/ActivityDoctor.drawio.svg", width: 100%, height: 165%, fit: "contain")
  ]
]

#slide(title: "Validation & testing results")[
  *Testing methodologies:*
  - service and unit tests - backend and components
  - manual testing - frontend
  - benchmarking and stress test - STT and LLM

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


#slide(title: "Pre-recorded demo")[
  #align(center + horizon)[
    Placeholder slide for Igor.

    Demo content will be added here.
  ]
]

