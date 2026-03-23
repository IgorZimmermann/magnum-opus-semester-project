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

To use the service, connect to the SMTP server using the `System.Net.Mail.MailMessage` class of the .NET framework.

An example of the example can be seen [here](https://stackoverflow.com/a/449897).

To access the WebUI, go to `http://localhost:8025`.
