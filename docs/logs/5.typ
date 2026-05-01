#import "../templates/meeting-logs.typ": meeting-log

#meeting-log(
  absentees: ((name: "Örs Tomaj Jeney", method: "notified"),),
  location: "SDU Alsion - J1.18",
  date: datetime(
    day: 2,
    month: 3,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)[

- We merged all approved pull requests and closed the first sprint.
- We analyzed a component-based design with our supervisor.
- We went through our Project Proposal with our supervisor.
- Supervisor showed us #link("https://cloud.sdu.dk")[UCloud].
- We made notes of the changes suggested.
- We split research tasks and put them in Jira.
- We gave story points using Story Point Poker.
- We distributed the issues and started a new sprint.

]