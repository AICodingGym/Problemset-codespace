#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/serverapi_test.go 2>/dev/null || true" EXIT
git checkout fe8d252c51114e922e6836055ef86a15f79ad042 -- scanner/serverapi_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestViaHTTP
