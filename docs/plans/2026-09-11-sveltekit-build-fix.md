# Plan: sveltekit build fix

Status: proposed
Generated: 2026-09-11T13:20:00+07:00

## Objective

The `sveltekit` template's `npm run build` fails out of the box
(`src/app.html does not exist`), contradicting its own README which
documents `npm run build` as a working command. Add the missing
`src/app.html` so the documented build command passes, and record the
change.

## Scope

- In scope: `templates/sveltekit/src/app.html` (new), `templates/sveltekit/README.md`
  (clarify), root `CHANGELOG.md` (record).
- Out of scope: nextjs-convex typecheck (requires `npx convex dev`, documented),
  spring-boot-api, python-package, repo-starter, github-actions, docs templates
  (all verified green by `scripts/verify-templates.sh`).

## Objectives

- [ ] OBJ-001: Add `templates/sveltekit/src/app.html` (minimal SvelteKit shell).
- [ ] OBJ-002: Run `npm run build` in `templates/sveltekit`; assert exit 0.
- [ ] OBJ-003: Update `templates/sveltekit/README.md` to note `src/app.html` is
  required (SvelteKit convention) so the build is self-documenting.
- [ ] OBJ-004: Update root `CHANGELOG.md` `[Unreleased]` with the fix entry.
- [ ] OBJ-005: Run `bash scripts/verify-templates.sh`; assert exit 0.
- [ ] OBJ-006: Commit the change on `master` and push to `origin`.

## Verification

```bash
cd templates/sveltekit && npm run build
bash scripts/verify-templates.sh
```
