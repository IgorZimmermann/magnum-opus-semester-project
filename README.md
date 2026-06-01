![Mona Lisa - Da Vinci's Magnum Opus](https://unwavering-hope-852874798e.media.strapiapp.com/apple_touch_icon_97bbbdbda2.png)

# MAGNUM OPUS Semester Project

This project is the work of this semester's project, a privacy-preserving OPD (Outpatient Department) management system. The project relies on skills gathered from this semester's subjects to provide a working solution for managing consultations in clinical environments, from booking to AI-assisted prescription. It follows a component based framework with distributed systems. 

## Components

| **Name** | **Function**          | **Port**        |
| -------- | --------------------- | --------------- |
| Echo     | Speech-to-text        | 3000            |
| Heimdall | Consultation Backend  | 5000            |
| Hermes   | Email (Web UI / SMTP) | 8025 / 1025     |
| Mneme    | Database (Postgres / Mongo) | 5432 / 27017 |
| Odin     | LLM                   | 11434           |
| Saga     | PDF Generation        | 3001            |
| Janus    | Booking Backend       | 5050            |
| Eir      | Consultation Frontend | 3002            |
| Iris     | Booking Frontend      | 3003            |

## Running with Docker

```bash
docker compose --profile llm up -d
```
If you are experiencing issues with opening either frontend during testing please open it in incognito or delete the browser data.

### OAuth Login (Seeded Accounts using Auth0)

#### Doctor
| Field    | Value                    |
|----------|--------------------------|
| Email    | alice.carter@example.com |
| Password | Acarter123!              |

#### Patient
| Field    | Value                |
|----------|----------------------|
| Email    | john.doe@example.com |
| Password | Jdoe123!             |
