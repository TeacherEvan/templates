# Architecture

> Last updated: 2026-01-01

## Purpose

Describe what this system does and the problem it solves, in 2–3 sentences a
new engineer can understand without further context.

## High-level design

```text
[ Client ] --> [ API ] --> [ Service ] --> [ Database ]
```

- **Client** — what the user touches.
- **API** — HTTP boundary, auth, validation.
- **Service** — business logic.
- **Database** — persistence.

## Key decisions

| Decision | Rationale | Alternative rejected |
|---|---|---|
| Use Postgres | Strong consistency, familiar tooling | Mongo (schema drift risk) |

## Boundaries & invariants

- The client is untrusted. Authorization lives in the backend.
- Secrets live in environment variables, never in source.

## Open questions

- [ ] How do we handle multi-region writes?
