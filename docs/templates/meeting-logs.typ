#let meeting-log(
  body,
  date: datetime(
    day: 2,
    month: 2,
    year: 2222,
    hour: 2,
    minute: 2,
    second: 2,
  ),
  location: "",
  members: ((name: ""),),
  absentees: ((name: "", method: ""),),
) = context {
  set text(
    size: 12pt,
    font: (
      "Helvetica Neue",
      "Helvetica",
      "Arial",
    ),
  )

  show link: underline

  set page(
    paper: "a5",
    numbering: "1",
  )

  set heading(
    numbering: "1.",
  )

  align(center)[
    #text(weight: "bold", size: 24pt)[Meeting Log]
    #v(20pt)
    #text(weight: "bold", "Date and time:")
    #text(date.display("[day].[month].[year] [hour]:[minute]"))
    \
    #text(weight: "bold", "Location:")
    #text(location)
    \
    #text(weight: "bold", "Attendees:")
    #text(
      members
        .map(m => {
          if (absentees.find(a => a.name == m.name) != none) {
            if (absentees.find(a => a.name == m.name).method == "online") {
              emph(m.name)
            } else if (absentees.find(a => a.name == m.name).method == "notified") {
              strike(m.name)
            } else {
              text(fill: rgb(255, 0, 0), strike(m.name))
            }
          } else {
            m.name
          }
        })
        .join(", "),
    )
  ]
  v(40pt)

  body
}
