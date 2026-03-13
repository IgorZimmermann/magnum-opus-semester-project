# Mneme - Database

## Database structure

### Relational db

PK - bold,
FK - underlined

- Doctors (int: **doc_id**, string: name, string: email)
- Patients (int: **pat_id**, string: name, string: email)
- Works_on (int: <u>**doc_id**</u>, int: **day_of_the_week**, time: starts_from, time: ends_at)
- Appointment (int: **appointment_id**, int: <u>doc_id</u>, int: <u>pat_id</u>, date: appointment_date, time: appointment_time, bool: email_confirmation_sent, datetime: email_sent_at, datetime: created_at, status: appointment_status)
- Enum status (confirmed, cancelled, completed)
- Constraint: Unique(doc_id, appointment_date, appointment_time)

Business logic:

- User selects the doctor
- System looks at when does that doctor work using day_of_the_week(appointment_date)
- Then the system looks at whether that timeslot has been occupied
- The system only displays a day if it has avaible timeslot
- Then the user can select a time
- The system inserts a row as the user saves the appointment
- The system sends an email
- The system updates the row based on the status response from the email service

Small notes:

- We might consider first selecting the appointment as i dont know how hard it is to show in the UI avaiable days and times (Igor?)

### Non Relational db

- Raw_transcripts

```js
const raw_transcript = {
    _id: ObjectId("5effaa5662679b5af2c58829"),
    appointmentId: 123,
    doctor: {
        id: 1,
        name: "Doctor Phil"
    },
    patient: {
        id: 67,
        name: "Bad bunny"
    },
    transcription: "Full transcription text...",
    createdAt: new ISODate("2024-01-15T10:30:00Z")
};
```

- Summary of transcription
```js
const summary = {
    _id = new ObjectId(),
    appointmentId: 123,
    doctor: {
		name: "Doctor Phil",
		id: 1
	},
    patient: {
		name: "Bad Bunny",
		id: 67
	},
    output: "Summarized text of the transcription",
    createdAt: new ISODate("2024-01-15T10:30:00Z"),
    status: "approved", //pending_review/approved
}
```

- Llm output
```js
const llm_output = {
    _id: new ObjectId(),
    appointmentId: 123,
    summaryId: ObjectId("..."),
    type: "advice", //advice/prescription
    generated_content: "LLM-generated text based on summary...",
    status: "approved", //pending/approved/rejected
    created_at: new ISODate("2024-01-15T10:40:00Z")
};
```

- Doctors note
```js
const doctors_note = {
    _id: new ObjectId(),
    appointmentId: 123,
	doctor: {
		name: "dr. Martin Hertz",
		id: 1239134283
	},
    symptoms: "Patient has deep, aching pain in his right eye. Patient has severe sensitivity to light (photophobia). Patient has noticeable redness, particularly around the iris. Patient has blurred or hazy vision. Patient notices the pupil in the affected eye is smaller than the other.",
	diagnosis: "iridocyclitis",
	description: "Iridocyclitis is a painful, often sudden, inflammation of both the iris and ciliary body in the front of the eye (anterior uveitis). Key symptoms include severe eye pain, red eye, sensitivity to light (photophobia), and blurry vision.",
	prescription: "You might need eye drops, topical eye ointments or pills.",
    advice: "Urgent Referral to an Ophthalmologist",
    pdf_url: "/exports/prescriptions/123.pdf"
    created_at: new ISODate("2024-01-15T10:50:00Z")
};
```

Small notes
- We have to go over the nonrel db schemas as it is very important how we want to format it. 
- I changed Igors format a bit just separated prescription and advice and also added a symptoms part.

## How to start container


```bash
docker compose up --build
```

## How to add to a `docker-compose`

-`.env.example`
```.env
POSTGRES_HOST=magnum-postgres
POSTGRES_PORT=5432
POSTGRES_DB=magnum
POSTGRES_USER=magnum_user
POSTGRES_PASSWORD=changeme

MONGO_HOST=magnum-mongo
MONGO_PORT=27017
MONGO_DB=magnum
MONGO_ROOT_USERNAME=magnum_user
MONGO_ROOT_PASSWORD=changeme

```
-`docker-compose`
```yaml
services:
  db:
    image: postgres:16
    restart: unless-stopped
    env_file: .env
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "${POSTGRES_PORT:-5432}:5432"

  mongo:
    image: mongo:7.0
    restart: unless-stopped
    env_file: .env
    environment:
      MONGO_INITDB_DATABASE: ${MONGO_DB}
      MONGO_INITDB_ROOT_USERNAME: ${MONGO_ROOT_USERNAME}
      MONGO_INITDB_ROOT_PASSWORD: ${MONGO_ROOT_PASSWORD}
    ports:
      - "${MONGO_PORT:-27017}:27017"
```

## Endpoints/Interface

