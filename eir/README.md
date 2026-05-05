# Eir - Consultation Frontend

Consultation frontend made using Next.js, for the doctor consultation workflow.

---

## Running with Docker (Recommended)

```bash
docker-compose up eir
```

---

## How to Run in Development

```sh
pnpm install
pnpm dev -p 3002
```

---

## File Structure

- `app/` — Contains the pages. Paths are resolved based on the file structure.
  - `app/page.tsx` → `/`
  - `app/appointment/[id]/page.tsx` → `/appointment/<id>`
  - `app/appointment/[id]/note/page.tsx` → `/appointment/<id>/note`

- `components/` — UI components used in the application. Mostly `shadcn/ui` components, but custom components would also go here.

- `hooks/` — Custom React hooks used in the application.

- `lib/` — Configuration logic for packages (like `auth0`). Custom utilities like date formatters, etc. would also go here.

---

### OAuth Login (Seeded Doctor Account using Auth0)

| Field    | Value                    |
|----------|--------------------------|
| Email    | alice.carter@example.com |
| Password | Acarter123!              |

---

## Tech Stack

- **Language/Framework:** TypeScript / Next.js
- **Key libraries:** auth0, react-query, shadcn/ui, TailwindCSS

---

## Endpoints / API

| Method | Path               | Description                              |
|--------|--------------------|------------------------------------------|
| GET    | /api/access-token  | Returns the current Auth0 access token.  |

---

## Environment Variables

| Variable              | Description                        | Example                    |
|-----------------------|------------------------------------|----------------------------|
| `AUTH0_DOMAIN`        | Auth0 tenant domain                | `dev-xxx.us.auth0.com`     |
| `AUTH0_CLIENT_ID`     | Auth0 application client ID        | `abc123`                   |
| `AUTH0_CLIENT_SECRET` | Auth0 application client secret    | `secret`                   |
| `AUTH0_SECRET`        | Secret used to encrypt session     | `a-long-random-string`     |
| `AUTH0_AUDIENCE`      | Auth0 API audience url             | `https://consultation-api` |
| `APP_BASE_URL`        | Base URL of the app                | `http://localhost:3002`    |