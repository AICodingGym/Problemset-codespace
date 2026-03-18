#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- log/redactrus_test.go server/app/auth_test.go 2>/dev/null || true" EXIT
git checkout 6bd4c0f6bfa653e9b8b27cfdc2955762d371d6e9 -- log/redactrus_test.go server/app/auth_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEntryDataValues/map_value,TestEntryDataValues,TestApp
