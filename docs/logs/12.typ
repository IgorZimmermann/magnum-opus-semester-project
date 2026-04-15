#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Örs Tomaj Jeney", method: "online"), (name: "Dávid Borka", method: "online"), (name: "Kristóf Ákos Koltai", method: "online")),
  location: "SDU Løkken - 104",
  date: datetime(
    day: 26,
    month: 3,
    year: 2026,
    hour: 14,
    minute: 30,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- Team members contributions since last meeting:
  - *Örs*: No contributions yet.
  - *Dávid*: No contributions yet.
  - *Sean*: Finished his taks (`OPUS-36`). Awaiting reviews.
  - *Igor*: No contributions yet.
  - *Denis*: No contributions yet.
  - *Ákos*: No contributions yet.

