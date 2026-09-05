# python_package

A practical, production-grade Python package starter using **src-layout** and **pytest**.

## What's included

- `src/python_package/` — importable package (with a trivial `add()` to demonstrate structure)
- `tests/` — pytest suite
- `pyproject.toml` — PEP 621 metadata, `setuptools` build, dev deps (`pytest`, `ruff`)
- `.github/workflows/ci.yml` — runs `pytest` on every push/PR

## What it is NOT

- Not a CLI or web service (extend `core.py` or add `click`/`fastapi` as needed).
- Not pre-configured for publishing (add `twine` + a release workflow when ready).

## Prerequisites

- Python 3.11+

## Run it

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
pytest
```

Expected: `3 passed`.
