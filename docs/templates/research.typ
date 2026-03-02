#let research(
  body,
  topic: "",
  author: "",
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
    numbering: none,
  )

  align(center)[
    #title(topic + " Research")
    Author: #author
  ]
  v(50pt)

  body
}
