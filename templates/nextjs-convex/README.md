# nextjs-convex

A practical full-stack starter: **Next.js 15 (App Router) + React 19 + Convex + TypeScript**.

## What's included

- Next.js App Router with a client page wired to a Convex query
- `convex/` backend with `tasks` schema + `list`/`add` functions
- TypeScript strict config, `.env.local.example`

## What it is NOT

- Not a styled/design-system app (add Tailwind or your own CSS).
- Not authenticated (add auth via Convex Auth or Clerk).

## Prerequisites

- Node 20+
- A free [Convex](https://convex.dev) account

## Run it

```bash
npm install
npx convex dev        # follow prompts to create a deployment
cp .env.local.example .env.local
npm run dev
```

Then open http://localhost:3000.

## Test / build

```bash
npm run typecheck
npm run build
```
