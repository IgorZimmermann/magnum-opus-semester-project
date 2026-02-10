#let presentation(
  body,
  title: "Presentation",
  end: "The End",
  members: ((name: ""),),
  dark: false,
) = context {
  set text(
    size: 16pt,
    fill: if dark {
      white
    } else {
      black
    },
    font: (
      "Helvetica Neue",
      "Helvetica",
      "Arial",
    ),
  )

  show link: underline

  show heading.where(level: 1): it => [
    #text(it, size: 80pt)
  ]

  show heading.where(level: 2): it => [
    #text(it, size: 40pt)
  ]

  set page(
    paper: "presentation-16-9",
    numbering: "1",
    fill: if dark {
      black
    } else {
      white
    },
    footer: context [
      #align(right)[
        #text(counter(page).display(), size: 12pt, weight: "bold")
      ]
    ],
  )

  page()[
    #heading(level: 1)[#title]
    #align(left + bottom)[
      #block(breakable: false)[
        #grid(
          columns: 1,
          gutter: 10pt,
          row-gutter: 20pt,
          ..members.map(m => [
            #block(breakable: false)[
              #text(m.name) -
              #link("mailto:" + m.email)
            ]
          ])
        )
      ]
    ]
  ]

  body

  page()[
    #align(center + horizon)[
      #heading(level: 1)[The End]
    ]
  ]
}

#let slide(
  body,
  title: "",
  alignment: horizon,
) = page(
  numbering: none,
  [
    #heading(level: 2)[#title]
    #block(height: 100% - 80pt, width: 100%)[
      #align(alignment)[
        #body
      ]
    ]
  ],
)
