#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 756f00f79ba8abf9fe53f3c6c818123b42eb7355 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLogEncoding,TestServeHTTP,TestLoad,TestDatabaseProtocol,TestScheme,TestJSONSchema,TestCacheBackend
