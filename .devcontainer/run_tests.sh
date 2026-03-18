#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/schema_test.go internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout f743945d599b178293e89e784b3b2374b1026430 -- config/schema_test.go internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_mustBindEnv,TestJSONSchema,TestCacheBackend,TestScheme,TestLogEncoding,TestServeHTTP,TestTracingExporter,TestLoad,TestDatabaseProtocol,Test_CUE,Test_JSONSchema
