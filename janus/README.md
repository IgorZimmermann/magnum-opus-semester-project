# Janus - Booking Backend

## How to start container

Describe what parameters are required and how to start it.

## How to add to a `docker-compose`

```yaml
# docker-compose configuration snippet
```

## Endpoints/Interface

email service test:

- run the email container
- start backend

- use the command to send a test mail:
```
    curl -X POST http://localhost:5093/api/email/send \
    -H "Content-Type: application/json" \
    -d '{
        "to": "test@example.com",
        "subject": "Test Email",
        "body": "asd",
        "isHtml": false
    }'
```
[HttpPost("send")]
ENDPOINT
Describe what endpoints/interfaces are exposed by the component.

Try to format it using headers, code blocks, bolds and italics.
