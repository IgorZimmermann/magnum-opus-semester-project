#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: ((name: "Örs Tomaj Jeney", method: "")),
  location: "SDU Alsion - J1.07",
  date: datetime(
    day: 4,
    month: 4,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)[
  - Scrum Master figured out proofreading and testing tasks for the next sprint.
  - We as a group figured out even more remaining tasks.
  - We calculated overall story point scores for all members.
  - We determined story point values for the tasks and distributed based on contributions so far.
]
