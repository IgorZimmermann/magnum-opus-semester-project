# Hermes - Email

SMTP mail testing service using Mailpit, with a built in web UI to check for any incoming emails sent during development

---

## Tech Stack

- **Image:** mailpit 

---

## Running with Docker (Recommended)

```bash
docker-compose up hermes
```

---

## Endpoints / API

| Interface | Address                  | Description                        |
|-----------|--------------------------|------------------------------------|
| Web UI    | `http://localhost:8025`  | Browser UI / email service         |
| SMTP      | `localhost:1025`         | SMTP server for sending test email |

---

## Environment Variables (in docker-compose)

| Variable                    | Description                                      | Example  |
|-----------------------------|--------------------------------------------------|----------|
| `MP_MAX_MESSAGES`           | Max number of messages to retain                 | `5000`   |
| `MP_DATABASE`               | Path to the Mailpit SQLite database file         | `/data/mailpit.db` |
