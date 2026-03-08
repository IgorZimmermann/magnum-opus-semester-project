#import "../templates/research.typ": research

#show: research.with(
  topic: "Secure Email",
  author: "Denis Nedzhibov",
)

= Researched options
- #link("https://mailpit.axllent.org/")[*Mailpit*]
- #link("https://mailtrap.io/")[Mailtrap]
- #link("https://mailu.io/2024.06/")[Mailu]

= Reason

After looking at various options for the secure email component, Mailpit appeared to be the most optimal choice.

Mailu would have been a great choice had the project needed to both send and receive emails. Since only the former is required, its full feature set would be excessive.

Mailtrap does not have an official Docker image and its cloud-hosted nature makes it unsuitable for the project.

Mailpit keeps all data locally, its Docker setup is relatively simple, and it covers exactly what the project requires: sending emails.
It is worth noting that Mailpit is intended for development use only; a production deployment would require a different service.


= How to get started

1. Add Mailpit and the backend environment variables to docker-compose.yml
```
mailpit:
  image: axllent/mailpit
  container_name: mailpit
  ports:
    - "8025:8025"  # Web UI
    - "1025:1025"  # SMTP
  restart: unless-stopped

backend:
  environment:
    - SMTP_HOST=mailpit
    - SMTP_PORT=1025
```

2. Start the container
```
docker compose up -d mailpit
```

3. Open http://localhost:8025 to confirm the Mailpit web UI is accessible

4. Connect the backend with the environment variables (Csharp example):
```
var client = new SmtpClient(
    Environment.GetEnvironmentVariable("SMTP_HOST"),
    int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT"))
);
await client.SendMailAsync("clinic@opd.local", "patient@example.com");
```
= Interactivity

After a doctor approves a prescription, the backend requests a PDF from the Typst service, then sends it to Mailpit as an SMTP message with the PDF attached.

Sends booking confirmation and cancellation emails to patients via the same SMTP interface.
