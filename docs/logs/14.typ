#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Dávid Borka", method: "online"),(name: "Örs Tomaj Jeney", method: "")),
  location: "SDU Alsion - J1.07",
  date: datetime(
    day: 20,
    month: 4,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)

- We discussed issues between our front-ends and back-ends.
- We discussed what needs to be included in the report, and what materials we can reuse for each one of them.
- We distributed the tasks.
- Supervisor gave us feedback:
  - Include unit testing coverage.
  - Make consultation UI have more functionality.
  - Use Bootstrap CI for LLM testing.
- We played Party Poker to determine story point values.
