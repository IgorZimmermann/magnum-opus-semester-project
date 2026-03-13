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

  #data.doctor.name (#data.doctor.id)
])

#v(50pt)

*Diagnosis:*
#data.diagnosis

*Description:*
#data.description

*Advice/Prescription:*
#data.advice_prescription
