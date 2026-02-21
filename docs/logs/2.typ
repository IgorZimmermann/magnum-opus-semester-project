#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: (),
  location: "SDU Alsion - J1.03",
  date: datetime(
    day: 16,
    month: 2,
    year: 2026,
    hour: 12,
    minute: 45,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- We signed the Group Contract.
- We contacted the group supervisor.
- We designed the initial component diagram.
- We decided the tech stack.
- We calculated the dependency depth.
