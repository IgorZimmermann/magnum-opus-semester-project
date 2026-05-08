# Iris - Booking Frontend

Booking frontend made using Next.js, for patients to manage and create appointments.

---

## Running with Docker (Recommended)

```bash
docker-compose up iris
```

---

## How to Run in Development

```sh
pnpm install
pnpm dev
```

---

## File Structure

- `app/` — Contains the pages. Paths are resolved based on the file structure.
  - `app/page.tsx` → `/`
  - `app/booking/page.tsx` → `/booking`

- `components/` — UI components used in the application. Mostly `shadcn/ui` components, but custom components would also go here.

- `hooks/` — Custom React hooks used in the application.

- `lib/` — Utility functions (e.g. class name helpers, date formatters).

---

## Tech Stack

- **Language/Framework:** TypeScript / Next.js
- **Key libraries:** auth0, react-query, shadcn/ui, TailwindCSS

---

## Environment Variables

| Variable              | Description                        | Example                    |
|-----------------------|------------------------------------|----------------------------|
| `AUTH0_DOMAIN`        | Auth0 tenant domain                | `dev-xxx.us.auth0.com`     |
| `AUTH0_CLIENT_ID`     | Auth0 application client ID        | `abc123`                   |
| `AUTH0_CLIENT_SECRET` | Auth0 application client secret    | `secret`                   |
| `AUTH0_SECRET`        | Secret used to encrypt session     | `a-long-random-string`     |
| `AUTH0_AUDIENCE`      | Auth0 API audience url             | `https://consultation-api` |
| `APP_BASE_URL`        | Base URL of the app                | `http://localhost:3003`    |