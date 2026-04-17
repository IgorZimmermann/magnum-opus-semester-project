#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Kristóf Ákos Koltai", method: "online")),
  location: "SDU Alsion - J1.07",
  date: datetime(
    day: 15,
    month: 4,
    year: 2026,
    hour: 13,
    minute: 0,
    second: 0,
  ),
  members: json("../team-members.json")
)

- We resolved merge conflicts and merged everything afterwards.
- We figured out new tasks and distributed them.
- We gave story point values using Story Point Poker.
- We started the new sprint.
