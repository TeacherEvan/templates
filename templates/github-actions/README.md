# github-actions

Reusable GitHub Actions workflows you can drop into any project.

## Files

| File | Use for |
|---|---|
| `node-ci.yml` | Node/TS projects: `npm ci`, lint, test, build |
| `python-ci.yml` | Python projects: matrix test across 3.11/3.12 |

## What it is NOT

- Not a deployment pipeline (add a `deploy` job with your host's action).
- Not a secret scanner (add a dedicated security step if required).

## Use it

Copy the relevant file into your repo's `.github/workflows/` and commit:

```bash
cp templates/github-actions/node-ci.yml your-repo/.github/workflows/
```

## Requirements

- Node workflows assume `lint`, `test`, and `build` scripts exist in `package.json`.
- Python workflows assume a `.[dev]` extra exposing `pytest`.
