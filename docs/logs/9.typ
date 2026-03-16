#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: (),
  location: "SDU Alsion - J1.07",
  date: datetime(
    day: 16,
    month: 3,
    year: 2026,
    hour: 12,
    minute: 0,
    second: 0,
  ),
  members: (..json("../team-members.json"), (name: "Riccardo Terrenzi")),
)

- We showed the supervisor our progress. Based on those he gave us feedback on what we should do:
  - Stress test / Implementation test
  - Benchmark testing - LLM & Speech-to-text
  - Fault tolerance test
  - Unit testing
- We discussed remaining work to be done on `OPUS-23`.
- We figured out tasks for the next sprint.
- We gave story point values to tasks and assigned people.
- The scrum master created the missing folders and READMEs.
