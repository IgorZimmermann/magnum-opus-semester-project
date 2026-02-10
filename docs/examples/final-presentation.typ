#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus",
  members: json("../team-members.json"),
)

#slide(
  title: "Introduction",
)[
  #grid(
    columns: 2,
    [
      #block(
        width: 100%,
        height: 150pt,
        inset: (
          left: 20pt,
          right: 20pt,
        ),
      )[
        #align(top)[
          #align(center)[
            *PROBLEM STATEMENT*
          ]
          - The standardization of height-adjustable desks, causing new problems
          - Management of large amount of desk prove to be difficult
        ]
      ]
    ],
    [
      #block(
        width: 100%,
        height: 150pt,
        inset: (
          left: 20pt,
          right: 20pt,
        ),
      )[
        #align(top)[
          #align(center)[
            *SOLUTION*
          ]
          - Providing a system for centralized desk management
          - Provide manager and worker comfort
          - Option of physical and web based control of desks
        ]
      ]
    ],
  )
]

#slide(
  title: "System Overview",
)[
  #grid(
    columns: 3,
    align: horizon,
    [
      #block(
        width: 100%,
        height: 120pt,
        inset: (
          left: 20pt,
          right: 20pt,
        ),
      )[
        #align(center)[
          *WEB SERVER*
        ]
        - Laravel
        - Both back-end and front-end
        - API endpoints
      ]
    ],
    [
      #block(
        width: 100%,
        height: 120pt,
        inset: (
          left: 20pt,
          right: 20pt,
        ),
      )[
        #align(top)[
          #align(center)[
            *DATABASE*
          ]
          - PostgreSQL
          - Additional data
        ]
      ]
    ],
    [
      #block(
        width: 100%,
        height: 120pt,
        inset: (
          left: 20pt,
          right: 20pt,
        ),
      )[
        #align(top)[
          #align(center)[
            *EMBEDDED*
          ]
          - Raspberry Pico W
          - One on each desk
        ]
      ]
    ],
  )
]

#slide(
  title: "Architecture",
)[
  #grid(
    columns: 2,
    [
      - Only web server exposed to local network
      - Database stays safe inside local server
      - REST API between Laravel and Simulator
      - REST API between Pico Ws and Laravel
    ],
    [
      #block(width: 100%)[
        #align(right + horizon)[
          #image("../images/snoop.jpg")
        ]
      ]
    ],
  )
]
