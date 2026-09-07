#!/usr/bin/env bash
# verify-templates.sh — mirror of .github/workflows/validate.yml for local use.
# Exits 0 if every template config parses + python-package pytest passes.
# Exits non-zero on any failure; prints a summary at the end.

set -euo pipefail

cd "$(dirname "$0")/.."

echo "=== parse YAML / JSON / XML ==="
python3 - <<'PY'
import sys, json, xml.dom.minidom as M
import yaml, pathlib

bad = 0
configs = [p for p in pathlib.Path('.').rglob('*')
           if p.is_file() and p.suffix in ('.yml', '.yaml', '.json')]
for f in configs:
    try:
        if f.suffix in ('.yml', '.yaml'):
            yaml.safe_load(f.read_text())
        else:
            json.loads(f.read_text())
    except Exception as e:
        print(f"FAIL {f}: {e}"); bad += 1

poms = list(pathlib.Path('.').rglob('pom.xml'))
for f in poms:
    try:
        M.parseString(f.read_text())
    except Exception as e:
        print(f"XML FAIL {f}: {e}"); bad += 1

print(f"parsed {len(configs)} YAML/JSON + {len(poms)} pom.xml; failures={bad}")
sys.exit(bad)
PY

echo
echo "=== every template has README.md ==="
missing=0
for d in templates/*/; do
    if [ ! -f "$d/README.md" ]; then
        echo "MISSING $d/README.md"; missing=$((missing+1))
    fi
done
total=$(find templates -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "templates with README.md: $((total - missing))/$total"
[ "$missing" -eq 0 ] || { echo "FAIL: $missing template(s) missing README.md"; exit 1; }

echo
echo "=== secret-pattern scan (sk_live_, pk_live_, AKIA, ghp_, Bearer) ==="
# Allow YOUR_* placeholders. Read .gitignore too (node_modules etc.) via ripgrep --no-ignore is undesirable.
hits=$(grep -rIE \
    --exclude-dir=node_modules --exclude-dir=target --exclude-dir=dist --exclude-dir=.svelte-kit \
    --include='*.md' --include='*.yml' --include='*.yaml' --include='*.json' \
    --include='*.ts' --include='*.tsx' --include='*.js' --include='*.svelte' \
    --include='*.py' --include='*.java' --include='*.xml' \
    -e 'sk_live_[A-Za-z0-9]{8,}' \
    -e 'pk_live_[A-Za-z0-9]{8,}' \
    -e 'AKIA[0-9A-Z]{16}' \
    -e 'ghp_[A-Za-z0-9]{30,}' \
    -e 'Bearer[[:space:]]+[A-Za-z0-9._-]{16,}' \
    templates/ scripts/ .github/ AGENTS.md README.md 2>/dev/null | grep -v 'YOUR_' || true)
if [ -n "$hits" ]; then
    echo "$hits"
    echo "FAIL: secret-like patterns found above"
    exit 1
fi
echo "secret-pattern scan: 0 hits"

echo
echo "=== python-package pytest ==="
( cd templates/python-package && python3 -m pip install -e ".[dev]" >/dev/null && python3 -m pytest -q )

echo
echo "=== sveltekit smoke test (npm install + vitest) ==="
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    ( cd templates/sveltekit && npm install --no-audit --no-fund >/dev/null && npm run test )
    echo "sveltekit: passed"
else
    echo "SKIP: node/npm not available on PATH"
fi

echo
echo "=== nextjs-convex smoke test (npm install) ==="
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    # nextjs-convex has no `test` script and `npm run typecheck` depends on the
    # Convex codegen output (`convex/_generated/*`), which is produced by
    # `npx convex dev` / `npx convex codegen` after the user wires up a
    # deployment per the template's README. We therefore only assert that
    # dependencies resolve + install (proves package.json is well-formed and
    # reachable). Run typecheck locally after `npx convex dev` first.
    ( cd templates/nextjs-convex && npm install --no-audit --no-fund >/dev/null )
    echo "nextjs-convex: passed (deps install; typecheck requires npx convex dev)"
else
    echo "SKIP: node/npm not available on PATH"
fi

echo
echo "=== spring-boot-api smoke test (mvn test) ==="
if command -v mvn >/dev/null 2>&1 && command -v java >/dev/null 2>&1; then
    # Pin JAVA_HOME to the JDK backing `which java`. On some systems (notably
    # Ubuntu 24.04 with Maven 3.8.7) the Surefire forked JVM silently picks up
    # a different Java than Maven's compile JVM, producing class-file version
    # mismatches even though no other JDK is on PATH. Forcing JAVA_HOME here
    # keeps compile + test JVMs in sync. CI uses actions/setup-java@v4 which
    # already sets this correctly.
    _java_home="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
    ( cd templates/spring-boot-api && JAVA_HOME="$_java_home" mvn -q test )
    echo "spring-boot-api: passed"
else
    echo "SKIP: mvn/java not available on PATH"
fi

echo
echo "ALL CHECKS PASSED"
