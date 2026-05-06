![Mona Lisa - Da Vinci's Magnum Opus](https://unwavering-hope-852874798e.media.strapiapp.com/apple_touch_icon_97bbbdbda2.png)

# MAGNUM OPUS Semester Project

This project is the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project relies on skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from booking to AI-assisted prescription. It follows a component based framework with distributed systems. 

## Components

| **Name** | **Function**   |
| -------- | -------------- |
| Echo     | Speech-to-text |
| Heimdall | Consultation Backend  |
| Hermes   | Email          |
| Mneme    | Database       |
| Odin     | LLM            |
| Saga     | PDF Generation |
| Janus    | Booking Backend|
| Eir      | Consultation Frontend |
| Iris     | Booking Frontend|

## Running with Docker

```bash
docker-compose up -d
```

### OAuth Login (Seeded Doctor Account using Auth0)

| Field    | Value                    |
|----------|--------------------------|
| Email    | alice.carter@example.com |
| Password | Acarter123!              |
