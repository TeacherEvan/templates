# Changelog

All notable changes to this repository are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres
to [Semantic Versioning](https://semver.org/).

## [0.1.0] - 2026-09-07

### Fixed
- `.github/workflows/validate.yml`: the YAML/JSON parse-check loop used
  `glob.glob('**/*.{yml,yaml,json}', recursive=True)`, which silently returns
  `[]` on Python 3.11 because `glob` does not perform brace expansion. CI was
  passing while parsing zero files. Switched to `pathlib.Path('.').rglob('*')`
  filtered by suffix; CI now actually validates every `*.yml`/`*.yaml`/`*.json`
  in the repo (including every template's `package.json` and `tsconfig.json`).

### Added
- `scripts/verify-templates.sh`: a local-first wrapper that mirrors the CI gate
  (parse YAML/JSON/XML, README presence check for every template, lightweight
  secret-pattern scan, `pytest` against `templates/python-package`).
- `CHANGELOG.md` (this file).

- `.github/workflows/validate.yml`: CI now runs the same secret-pattern
  scan (`sk_live_`, `pk_live_`, `AKIA`, `ghp_`, `Bearer`) as
  `scripts/verify-templates.sh`. Local-only enforcement was hiding a CI gap
  where a leaked key would pass the remote gate. Mirrors the local recipe
  verbatim so the two stay in sync.
- `.github/workflows/validate.yml`: removed a stale comment that referenced
  `docs/.scratch-audit/CODEBASE-STATE.md` — that file is gitignored and never
  tracked. Comment now reads `Mirrors scripts/verify-templates.sh.`


### Changed
- `AGENTS.md` "Verification" section now points at `scripts/verify-templates.sh`
  in place of the inline heredoc recipe.
- `README.md` "How to use" mentions the verification step.
