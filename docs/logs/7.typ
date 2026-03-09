#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: (),
  location: "SDU Alsion - J1.01-C",
  date: datetime(
    day: 9,
    month: 3,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)

- We showed the supervisor our progress and our new diagrams. Based on those he gave us the feedback that we should start implementing from the smallest components, building up to the biggest.
- We went through our flow diagrams, so everyone understands how the application works.
- Everyone presented their research to the rest of the members.
- Final tech stack:
  - Backend: C\# ASP.NET
  - Speed-to-text: Faster-Whisper
  - Authentication: Auth0
  - Email: MailPit
  - LLM: LiquidAI
  - PDF Generation: Typst
  - UI: Next.js
- We split service development into tasks, gave story points and assigned tasks.
