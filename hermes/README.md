# Hermes - Email

## How to start container

``` docker
docker run -d \
--restart unless-stopped \
--name=mailpit \
-p 8025:8025 \
-p 1025:1025 \
axllent/mailpit
```
## How to add to a `docker-compose`

```yaml
services:
    mailpit:
        image: axllent/mailpit
        container_name: mailpit
        restart: unless-stopped
        volumes:
            - ./data:/data
        ports:
            - 8025:8025 # Web UI
            - 1025:1025 # SMTP
        environment:
            MP_MAX_MESSAGES: 5000
            MP_DATABASE: /data/mailpit.db
            # app can use any credential without TLS 
            # dev/testing
            MP_SMTP_AUTH_ACCEPT_ANY: 1 
            MP_SMTP_AUTH_ALLOW_INSECURE: 1
```

## Endpoints/Interface

**SMTP**

- URL: `<localhost>:1025`

App connects here to send mail automatically.

**Web UI**

- URL: `http://<localhost>:8025`

Browser-based email client for viewing, searching, and managing captured emails. In our case mostly for testing
