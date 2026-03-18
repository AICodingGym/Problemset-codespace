#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- utils/singleton/singleton_test.go 2>/dev/null || true" EXIT
git checkout d613b1930688422122796b43acb3caf2538c8fd1 -- utils/singleton/singleton_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSingleton
