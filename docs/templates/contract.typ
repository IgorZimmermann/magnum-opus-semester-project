#let contract(
  body,
  title: "",
  signatories: ((name: ""),),
  date: datetime.today(),
  location: "",
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
    paper: "a4",
    numbering: "1",
  )

  set heading(
    numbering: "1.",
  )

  align(center)[
    #text(weight: "bold", size: 24pt)[#title]
    \
    #text("Date:")
    #text(date.display("[day].[month].[year]"))
    \
    #text("Location:")
    #text(location)
  ]
  v(40pt)

  body

  heading("Signatures")
  v(3em)
  grid(
    columns: 3,
    gutter: 1.2em,
    row-gutter: 4em,
    ..signatories.map(p => [
      #block(breakable: false)[
        #v(40pt)
        #line(length: 100%)
        #align(left)[#p.name]
      ]
    ])
  )
}
