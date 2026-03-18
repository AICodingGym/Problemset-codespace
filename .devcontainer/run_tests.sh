#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- .github/workflows/database-test.yml .github/workflows/test.yml config/config_test.go test/api 2>/dev/null || true" EXIT
git checkout c154dd1a3590954dfd3b901555fc6267f646a289 -- .github/workflows/database-test.yml .github/workflows/test.yml config/config_test.go test/api

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestValidate,TestLoad,TestScheme,TestServeHTTP
