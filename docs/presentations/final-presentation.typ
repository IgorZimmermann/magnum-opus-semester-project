#import "../templates/presentation.typ": presentation, slide

#show: presentation.with(
  title: "Magnum Opus Clinic",
  members: json("../team-members.json"),
)

#slide(title: "Intro — problem analysis & requirements")[
  #align(center + horizon)[
    Placeholder slide for Akos.

    Problem analysis and requirements will be added here.
  ]
]


/* - This semesters project design main focus was on redundancy and fail-safe systems. This is why we choose the component based systmes framework and created two instances of the frontend, backend and database. This ensures that if one part of the system fails then the others can still keep going.
- Two backends: one relational and one document based.
- Two frontends: Contract first approach. one is for consultation doctor side, the other is proof of concept
- C# ASP:NET: layered architecture: Controllers, services, interfaces, repositories Services depend only on interfaces, never concrete implementations dependency injection lets ASP.NET wire in the right backend/database at runtime*/
#slide(title: "System design and architecture")[
  #align(center + horizon)[
    #image("../images/ApplicationDiagram.jpg", width: 100%, height: 105%, fit: "contain")
  ]
]

#slide(title: "Component diagram")[
  #align(center + horizon)[
    Placeholder slide for Sean.

    Component diagram content will be added here.
  ]
]

#slide(title: "Use-case / sequence diagram")[
  #align(center + horizon)[
    Placeholder slide for Denis.

    Use-case and sequence diagram content will be added here.
  ]
]

#slide(title: "Validation & testing results")[
  #align(center + horizon)[
    Placeholder slide for David.

    Validation and testing results will be added here.
  ]
]

#slide(title: "Pre-recorded demo")[
  #align(center + horizon)[
    Placeholder slide for Igor.

    Demo content will be added here.
  ]
]

