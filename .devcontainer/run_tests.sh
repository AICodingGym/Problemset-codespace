#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- db/backup_test.go 2>/dev/null || true" EXIT
git checkout 55730514ea59d5f1d0b8e3f8745569c29bdbf7b4 -- db/backup_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDB
