#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- roles_test.go 2>/dev/null || true" EXIT
git checkout 0cb341c926713bdfcbb490c69659a9b101df99eb -- roles_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRolesCheck,TestRolesEqual
