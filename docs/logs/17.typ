#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: (),
  location: "SDU Alsion - Software Room",
  date: datetime(
    day: 11,
    month: 5,
    year: 2026,
    hour: 12,
    minute: 5,
    second: 0,
  ),
  members: (..json("../team-members.json"))
)[
- We discussed the issues between our backends.
- We discussed remaining tasks.
]

