#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: (),
  location: "SDU Alsion - J1.03",
  date: datetime(
    day: 23,
    month: 2,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)[

- We signed the Supervisor Contract.
- We discussed our diagram made in the previous meeting and realised that it's a Application Layer diagram.
- Supervisor recommended that we use a NoSQL database.
- Supervisor recommended that we use LiquidAI or Gwen and run it via Ollama.
- Supervisor proposed we could implement RAG.
- Ákos gave notice that he'll only be available online for the 02.26.
- We broke the project proposal down into tasks, gave story points, and assigned each task.
- We started Sprint 1.
- Igor created the base for the project proposal.
- We went through the user flows.
- We created a component diagram based on the user flow.

]