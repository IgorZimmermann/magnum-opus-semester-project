#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: ((name: "Sean Larsen", method: "notified"),),
  location: "SDU Alsion - Software Room",
  date: datetime(
    day: 27,
    month: 4,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"))
)[

- We went through all open pull requests and discussed requested changes.
- We completed missing pull requests.
- We figured out new tasks.
- We determined story point values using Story Point Poker.

]