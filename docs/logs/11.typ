#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Örs Tomaj Jeney", method: "notified"),(name: "Kristóf Ákos Koltai", method: "online")),
  location: "SDU Alsion - J1.07",
  date: datetime(
    day: 23,
    month: 3,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)

- We resolved merge conflicts.
- We showed our supervisor our progress.
- He gave us feedback on what we could do for the next Sprint.
- We closed the sprint and came up with new tasks for the next one.
- We decided on Story Point values using Story Point Poker.
- We started the new sprint.
