#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/schema_test.go internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout cd18e54a0371fa222304742c6312e9ac37ea86c1 -- config/schema_test.go internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScheme,TestJSONSchema,Test_mustBindEnv,TestLoad,TestCacheBackend,TestTracingExporter,TestLogEncoding,Test_CUE,TestServeHTTP,TestDatabaseProtocol
