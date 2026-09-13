# Plan: templates repo verification (2026-09-14)

Status: COMPLETE (all objectives satisfied on the live tree; no re-derivation).

## Objectives

- [x] OBJ-001 — YAML/JSON/XML parse: every config in templates/ + .github/ parses (verify-templates.sh).
- [x] OBJ-002 — README presence: all 7 templates ship README.md.
- [x] OBJ-003 — Secret scan: 0 hits for sk_live_/pk_live_/AKIA/ghp_/Bearer across templates, scripts, .github, AGENTS.md, README.md.
- [x] OBJ-004 — python-package: `pip install -e .[dev]` + `pytest -q` passes.
- [x] OBJ-005 — sveltekit: `npm install` + `npm run test` (vitest) passes.
- [x] OBJ-006 — nextjs-convex: `npm install` passes (typecheck requires `npx convex dev`, out of scope for template smoke).
- [x] OBJ-007 — spring-boot-api: `mvn test` passes (Java 21).
- [x] OBJ-008 — repo-starter + github-actions + docs: structurally present, no runnable gate beyond parse/README checks.
- [x] OBJ-009 — Working tree clean; no uncommitted or untracked changes; branch master aligned with origin/master.
- [x] OBJ-010 — docs/.scratch-audit/ gitignored (per skill pitfall); no audit scratch leaked into tree.

## Evidence

`bash scripts/verify-templates.sh` -> ALL CHECKS PASSED, exit 0.
`git status -s` -> clean. `git diff --stat HEAD` -> empty.

## Definition of Done

All objectives ticked against live-tree evidence; no source changes required.
