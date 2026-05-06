#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: (),
  location: "SDU Løkken - 104",
  date: datetime(
    day: 5,
    month: 3,
    year: 2026,
    hour: 13,
    minute: 45,
    second: 0,
  ),
  members: json("../team-members.json"),
)[

- Team members contributions since last meeting:
  - *Örs*: No contributions yet.
  - *Dávid*: Setup LLMs for testing (`OPUS-12`).
  - *Sean*: Completed task (`OPUS-18`). Resolved requested changes. PR merged.
  - *Igor*: No contributions yet.
  - *Denis*: No contributions yet. Will not be done with task by Friday.
  - *Ákos*: Has started researching task (`OPUS-15`).

]