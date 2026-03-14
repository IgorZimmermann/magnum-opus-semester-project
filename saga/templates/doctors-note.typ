#set page(
  paper: "a4"
)

#set text(
  size: 16pt
)

#let data = json(
  bytes(
    sys.inputs.at(
      "data",
      default: read("example.json")
    )
  )
)

#align(center, [
  #title(
    "Doctor's Note"
  )

  #datetime.today().display()

  #grid(
    columns: (1fr, 1fr),
    block[
      *Doctor*

      #data.doctor.name

      #data.doctor.id
    ],
    block[
      *Patient*

      #data.patient.name

      #data.patient.id
    ]
  )
])

#v(50pt)

*Diagnosis:*
#data.diagnosis

*Description:*
#data.description

*Advice/Prescription:*
#data.advice_prescription
