#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- oval/util_test.go 2>/dev/null || true" EXIT
git checkout d576b6c6c15e56c47cc3e26f5878867677d4a9ea -- oval/util_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_major
