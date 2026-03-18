#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout abaa5953795afb9c621605bb18cb32ac48b4508c -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad
