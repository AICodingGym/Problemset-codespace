#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 0fd09def402258834b9d6c0eaa6d3b4ab93b4446 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLogEncoding,TestServeHTTP,TestLoad,TestTracingExporter,TestScheme,Test_mustBindEnv,TestJSONSchema,TestCacheBackend,TestDatabaseProtocol
