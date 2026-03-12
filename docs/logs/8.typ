#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: (),
  location: "SDU Løkken - 104",
  date: datetime(
    day: 12,
    month: 3,
    year: 2026,
    hour: 13,
    minute: 25,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- Team members contributions since last meeting:
  - *Örs*: No contributions yet.
  - *Dávid*: Only has last section remaining (`OPUS-20`).
  - *Sean*: Completed task (`OPUS-25`). Waiting for review.
  - *Igor*: Has begun development (`OPUS-19`).
  - *Denis*: Has experimented, only has to document (`OPUS-21`).
  - *Ákos*: Has started researching task (`OPUS-22`). Will not open request by Friday.
