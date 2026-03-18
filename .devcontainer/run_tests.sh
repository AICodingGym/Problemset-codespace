#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 518ec324b66a07fdd95464a5e9ca5fe7681ad8f9 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad
