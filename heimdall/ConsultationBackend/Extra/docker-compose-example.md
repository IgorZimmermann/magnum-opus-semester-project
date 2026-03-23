This is the docker compose i was using during development
Place it in the magnus opus repo dir

services:
  odin:
    build:
      context: ./odin
      dockerfile: Dockerfile
    container_name: ollama
    restart: unless-stopped
    volumes:
      - ollama_data:/root/.ollama
    ports:
      - "8000:11434" # Align with appsettings.json Services:LLM BaseUrl (http://localhost:8000)

  hermes:
    image: axllent/mailpit
    container_name: mailpit
    restart: unless-stopped
    volumes:
      - hermes_data:/data
    ports:
      - "8025:8025" # Web UI
      - "1025:1025" # SMTP
    environment:
      MP_MAX_MESSAGES: 5000
      MP_DATABASE: /data/mailpit.db
      MP_SMTP_AUTH_ACCEPT_ANY: 1
      MP_SMTP_AUTH_ALLOW_INSECURE: 1

  echo:
    build:
      context: ./echo
      dockerfile: Dockerfile
    container_name: faster-whisper
    restart: unless-stopped
    ports:
      - "8003:3000" # Align with appsettings.json Services:SpeechToText BaseUrl (http://localhost:8003)

  saga:
    build:
      context: ./saga
      dockerfile: Dockerfile
    container_name: pdf-generator
    restart: unless-stopped
    ports:
      - "8001:3000" # Align with appsettings.json Services:Pdf BaseUrl (http://localhost:8001)

  heimdall:
    build:
      context: ./heimdall/ConsultationBackend
      dockerfile: Dockerfile
    container_name: consultation-backend
    restart: unless-stopped
    ports:
      - "5096:8080"
    environment:
      - ConnectionStrings__Postgres=Host=postgres;Port=5432;Database=consultationdb;Username=postgres;Password=postgres
      - MongoDbSettings__ConnectionString=mongodb://root:example@mongo:27017
      - MongoDbSettings__DatabaseName=consultationdocs
      - Services__LLM__BaseUrl=http://odin:11434
      - Services__Pdf__BaseUrl=http://saga:3000
      - Services__Email__BaseUrl=http://hermes:8025
      - Services__SpeechToText__BaseUrl=http://echo:3000
    depends_on:
      - postgres
      - mongo
      - odin
      - echo
      - saga
      - hermes

  postgres:
    image: postgres:16
    container_name: postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: consultationdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "5433:5432"

  mongo:
    image: mongo:7.0
    container_name: mongo
    restart: unless-stopped
    environment:
      MONGO_INITDB_DATABASE: consultationdocs
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example
    volumes:
      - mongodata:/data/db
    ports:
      - "27017:27017"

volumes:
  ollama_data:
  hermes_data:
  pgdata:
  mongodata: