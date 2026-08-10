# docs

Documentation templates you can copy into any project.

## Files

| File | Use for |
|---|---|
| `ARCHITECTURE.md` | System overview, boundaries, key decisions |
| `ADR-0001-template.md` | Architecture Decision Record (copy & renumber) |
| `RUNBOOK-template.md` | Operational runbook for a service |
| `API-reference-template.md` | REST API reference |

## What it is NOT

- Not a user guide or tutorial (write those separately).
- Not auto-generated (swagger/openapi can feed `API-reference-template.md`).

## Use it

```bash
cp templates/docs/ADR-0001-template.md docs/ADR-0007-database-choice.md
```
