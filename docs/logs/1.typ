#import "../templates/meeting-logs.typ": meeting-log

#show: meeting-log.with(
  absentees: ((name: "Örs Tomaj Jeney", method: "notified"),),
  location: "SDU Alsion - U110",
  date: datetime(
    day: 10,
    month: 2,
    year: 2026,
    hour: 12,
    minute: 10,
    second: 0,
  ),
  members: json("../team-members.json"),
)

- We went through the summaries of each project and picked our two favourites. Afterwards, we dove deeper into those and finally picked *OPD-Vertex*.

- We went through the proposed Group Contract rule-by-rule, discussed and came up with solutions. By the end we got a contract, which everyone agrees to and finds acceptable.

- We appointed a Scrum Master (Igor Zimmermann), who set Jira up for our project.

- We discussed our availability for the Midterm Presentation of the 9th of April and ultimately came up with the fact that we need to move our presentation to a later date.
