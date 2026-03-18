#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout b433bd05ce405837804693bebd5f4b88d87133c8 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestJSONSchema,TestLogEncoding,Test_mustBindEnv,TestTracingExporter,TestServeHTTP,TestLoad,TestDatabaseProtocol,TestScheme,TestCacheBackend
