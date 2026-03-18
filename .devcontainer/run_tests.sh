#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout af7a0be46d15f0b63f16a868d13f3b48a838e7ce -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_mustBindEnv,TestJSONSchema,TestServeHTTP,TestLoad,TestScheme,TestCacheBackend,TestDatabaseProtocol,TestLogEncoding
