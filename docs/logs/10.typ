#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Örs Tomaj Jeney", method: "online"), (name: "Dávid Borka", method: "online")),
  location: "SDU Løkken - 104",
  date: datetime(
    day: 19,
    month: 3,
    year: 2026,
    hour: 13,
    minute: 40,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- Team members contributions since last meeting:
  - *Örs*: No contributions yet.
  - *Dávid*: No contributions yet.
  - *Sean*: Working heavily on his task (`OPUS-27`).
  - *Igor*: Has finished his task (`OPUS-24`). All approved.
  - *Denis*: Has opened a pull request for his task (`OPUS-26`).
  - *Ákos*: Has started working on his task (`OPUS-29`).
