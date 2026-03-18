#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/cache/cache_test.go 2>/dev/null || true" EXIT
git checkout c782838c3a174fdff80cafd8cd3b1aa4dae8beb2 -- lib/cache/cache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestState
