#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/players_test.go 2>/dev/null || true" EXIT
git checkout 97434c1789a6444b30aae5ff5aa124a96a88f504 -- core/players_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCore
