# Changelog

All notable changes to this repository are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres
to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Fixed
- `scripts/verify-templates.sh`: pin `JAVA_HOME` to the JDK backing `which java`
  before invoking `mvn test` for `templates/spring-boot-api`. Without this,
  Maven 3.8.7's Surefire forked JVM silently picks up a different Java than
  the compile JVM, producing a `class file version 65 vs 61` mismatch on
  some hosts (notably Ubuntu 24.04). CI is unaffected (`actions/setup-java@v4`
  already pins JAVA_HOME).

### Added
- `scripts/verify-templates.sh`: secret-pattern scan now excludes
  `node_modules/`, `target/`, `dist/`, and `.svelte-kit/` so the scan only
  covers source/config (a base64 blob inside a dependency would otherwise
  match the high-entropy `Bearer` pattern after `npm install` runs).
- `scripts/verify-templates.sh`: smoke-test sections for `templates/sveltekit`
  (`npm install` + `npm run test`), `templates/nextjs-convex` (`npm install`
  only — typecheck requires Convex codegen output from `npx convex dev`,
  documented in the template's README), and `templates/spring-boot-api`
  (`mvn -q test`). Each section is wrapped in a `command -v` guard so the
  script gracefully skips when its toolchain is not on PATH (the script still
  runs on a Python-only box). Closes the gap with AGENTS.md rule #2
  ("Every package.json/pyproject.toml/pom.xml MUST install and the documented
  test/build command MUST pass in a clean environment"), which previously
  applied only to `python-package`.
- `.github/workflows/validate.yml`: mirrored the new smoke-test sections.
  Added `actions/setup-node@v4` (Node 20) for the two JS templates and
  `actions/setup-java@v4` (Temurin 21, Maven cache) for the Spring Boot
  template. The CI/local mirror invariant from `scripts/verify-templates.sh`'s
  header comment is preserved.

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
