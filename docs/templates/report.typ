#let appendixState = state("appendices", ())

#let appendix(label, body, caption) = {
  appendixState.update(old => old + ((label, body, caption),))
}

#let report(
  body,
  title: "",
  authors: ((name: "", email: ""),),
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

  set super(
    size: 6pt,
  )

  show raw: set text(
    size: 10pt,
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    text()[
      #if (it.numbering != none) {
        counter(heading).display()
      }
      #it.body]
    parbreak()
  }

  page(
    numbering: none,
  )[
    #align(horizon + center)[
      #place(
        center + top,
        block[
          #image("../images/mona.png", width: 40%)
          #place(top + right, "*", dx: 5pt)
        ],
        float: true,
      )

    ]

    #align(horizon + center)[
      #text(weight: "bold", size: 24pt)[#title]
    ]

    #align(bottom + center)[
      #grid(
        columns: 1,
        gutter: 10pt,
        row-gutter: 20pt,
        ..authors.map(author => [
          #block(breakable: false)[
            #text(author.name) -
            #link("mailto:" + author.email)
          ]
        ])
      )

      #v(40pt)

      \* The Mona Lisa is considered as Da Vinci's magnum opus.\ This project is our magnum opus.
    ]
  ]

  outline()

  pagebreak()

  body

  pagebreak()

  context [
    #if appendixState.get().len() != 0 {
      heading(numbering: none, level: 1)[Appendix]
      v(20pt)
    }
  ]

  show figure: set figure(
    numbering: "A.1",
    supplement: "Appendix Figure",
  )

  context [
    #for (lbl, body, caption) in appendixState.get() [
      #align(center + horizon)[
        #figure(body, caption: caption) #lbl
      ]
      #pagebreak(weak: true)
    ]
  ]
}
