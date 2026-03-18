#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout ebb3f84c74d61eee4d8c6875140b990eee62e146 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestCacheBackend,TestLogEncoding,TestScheme,TestJSONSchema,Test_mustBindEnv,TestServeHTTP,TestTracingExporter,TestDatabaseProtocol
