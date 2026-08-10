# AGENTS.md — templates

This repository is a **curated collection of practical, production-grade project templates**. Each folder under `templates/` is an independent, copy-and-go starter. Agents and humans alike should treat each template as a self-contained unit.

## Operating Rules

1. **Each template is independent.** Do not add cross-template dependencies. A user copies one folder, not the whole repo.
2. **Keep templates runnable.** Every `package.json` / `pyproject.toml` / `pom.xml` MUST install and the documented `test`/`build` command MUST pass in a clean environment.
3. **Secrets are forbidden in templates.** Use `.env.example` with placeholder values (`YOUR_*` / `change-me`). Never commit real keys.
4. **Pin major versions, not exact patches**, so templates stay fresh without breaking. Note the minimum required runtime (e.g. `Node 20+`, `Java 21`).
5. **Document honestly.** Every template's `README.md` must state: what it is, what it is NOT, prerequisites, and the exact commands to install/run/test.
6. **Lint before you commit.** YAML/JSON must parse; TS/JS must be syntactically valid; Python must `py_compile` and pass `pytest`.

## Structure

```
templates/
  repo-starter/      # bare repo skeleton (LICENSE, .gitignore, etc.)
  nextjs-convex/     # Next.js 15 App Router + Convex
  sveltekit/        # SvelteKit starter
  spring-boot-api/   # Spring Boot 3 REST API + Postgres
  python-package/    # src-layout Python package with pytest
  github-actions/    # reusable CI workflows
  docs/              # documentation templates (ARCH, ADR, runbook, API)
.github/workflows/   # CI that validates THIS repo's templates
```

## Verification

The root CI (`.github/workflows/validate.yml`) runs:
- YAML/JSON/XML parse check across all templates
- `pytest` against `templates/python-package`
- structural checks for the other templates

Run locally before pushing:
```bash
python3 - <<'PY'
import yaml, json, glob, sys, xml.dom.minidom as M
bad=0
for f in glob.glob('**/*.{yml,yaml,json}', recursive=True):
    try:
        (yaml.safe_load if f.endswith(('yml','yaml')) else json.load)(open(f))
    except Exception as e:
        print("PARSE FAIL", f, e); bad+=1
for f in glob.glob('**/pom.xml', recursive=True):
    try: M.parse(f)
    except Exception as e: print("XML FAIL", f, e); bad+=1
sys.exit(bad)
PY
pytest templates/python-package
```