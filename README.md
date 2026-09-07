# templates

A curated collection of **practical, production-grade project templates** by TeacherEvan. Copy any folder under `templates/` into your own repo and start building — no boilerplate archaeology required.

## What's inside

| Template | Stack | Best for |
|---|---|---|
| [`repo-starter`](templates/repo-starter) | Neutral | A clean repo skeleton: LICENSE, `.gitignore`, CONTRIBUTING, SECURITY, CoC, CHANGELOG |
| [`nextjs-convex`](templates/nextjs-convex) | Next.js 15 (App Router) + React 19 + Convex + TypeScript | Full-stack web apps with real-time backend |
| [`sveltekit`](templates/sveltekit) | SvelteKit + Vite + TypeScript | Fast, SSR-capable web apps and demos |
| [`spring-boot-api`](templates/spring-boot-api) | Spring Boot 3 + Java 21 + PostgreSQL + Flyway | Production REST APIs / microservices |
| [`python-package`](templates/python-package) | Python (src-layout) + pytest + GitHub Actions | Libraries, CLIs, and services in Python |
| [`github-actions`](templates/github-actions) | Reusable workflows | Drop-in CI for Node and Python projects |
| [`docs`](templates/docs) | Markdown | ARCHITECTURE, ADR, runbook, and API-reference templates |

## How to use

```bash
# Copy a single template into your new project
cp -r templates/nextjs-convex my-new-app
cd my-new-app
pnpm install        # or: npm install
pnpm dev
```

Each template is self-contained and documented in its own `README.md`.

Before contributing, run the verification recipe:

```bash
bash scripts/verify-templates.sh
```

It parses every YAML/JSON/XML config in the repo, checks each template has a `README.md`, scans for accidental secrets, and exercises `templates/python-package`'s `pytest` suite — the same gate CI runs.

## Principles

- **Runnable over impressive.** Every template's test/build command passes in a clean environment.
- **No secrets.** Placeholders only.
- **Honest docs.** Each README says what the template is *and what it is not*.

## Contributing

See [`templates/repo-starter/CONTRIBUTING.md`](templates/repo-starter/CONTRIBUTING.md). Agents: follow [`AGENTS.md`](AGENTS.md).

## License

Templates are released under MIT unless a template's own `LICENSE` says otherwise.
