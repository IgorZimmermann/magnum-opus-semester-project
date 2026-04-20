# Eir - Consultation Frontend

## How to run in development

1. Run via pnpm on port `3002`
    ```sh
    pnpm dev -p 3002
    ```

## File structure

- `app/`
    This folder contains the pages.

    Paths are resolved based on the file structure.
    `app/page.tsx -> /`, `app/appointment/[id]/page.tsx -> /appointment/<id>`, `app/appointment/[id]/note/page.tsx -> /appointment/<id>/note`

- `components/`
    This folder contains the ui components used in the application.

    In this application this folder is mostly used by `shadcn/ui` components, but custom components would also go here.

- `hooks/`
    This folder contains the custom React hooks used in the application.

- `lib/`
    This folder mainly contains configuration logic for packages (like `auth0`).

    Custom utilities like date formatters, etc. would also go here.
