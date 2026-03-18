#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/touchid/api_test.go 2>/dev/null || true" EXIT
git checkout 8302d467d160f869b77184e262adbe2fbc95d9ba -- lib/auth/touchid/api_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRegisterAndLogin
