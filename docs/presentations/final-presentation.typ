#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus Clinic",
  members: json("../team-members.json"),
)

#slide(title: "Intro — problem analysis & requirements")[
  #align(center + horizon)[
    Placeholder slide for Akos.

    Problem analysis and requirements will be added here.
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

#slide(title: "Component diagram")[
  #align(center + horizon)[
    Placeholder slide for Sean.

    Component diagram content will be added here.
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

