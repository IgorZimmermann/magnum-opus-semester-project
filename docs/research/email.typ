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

After looking at various options for the secure email component:
Mailtrap's lack of offical Docker image and it being cloud-hosted make it not the proper tool for the project;

Mailu would be a great choice if the project needed to both send and receive emails. Since only the former service will be utilised, it makes this option too heavy;

Mailpit appeared to be the most optimal choice due to data staying within the local network and its relative simple set up in Docker.


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
