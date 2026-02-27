#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Kristóf Ákos Koltai", method: "online"),),
  location: "SDU Løkken - 104",
  date: datetime(
    day: 26,
    month: 2,
    year: 2026,
    hour: 13,
    minute: 38,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- Team members contributions since last meeting:
  - *Örs*: Task in progress (`OPUS-7`), content has been written. Only has to copy to `project-proposal` file.
  - *Dávid*: No contributions yet.
  - *Sean*: Completed task (`OPUS-10`). Resolved requested changes. PR ready to merge.
  - *Igor*: No contributions yet.
  - *Denis*: No contributions yet.
  - *Ákos*: Has started writing the text for both tasks (`OPUS-5`, `OPUS-6`).

- Updated PR template to include point about moving task to `In Review` column.
