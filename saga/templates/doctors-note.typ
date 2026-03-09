#let data = json(bytes(sys.inputs.at(
  "data",
  default: "{
    \"doctor\": {
      \"name\": \"albert\",
      \"id\": 0
    }
  }",
)))

#title(
  "Doctor's Note",
)

#data.doctor.name - #data.doctor.id
