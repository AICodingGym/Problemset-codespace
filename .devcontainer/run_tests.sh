#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- .github/workflows/integration-test.yml internal/cache/redis/client_test.go internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 02e21636c58e86c51119b63e0fb5ca7b813b07b1 -- .github/workflows/integration-test.yml internal/cache/redis/client_test.go internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLogEncoding,TestCacheBackend,TestDefaultDatabaseRoot,TestScheme,TestTracingExporter,Test_mustBindEnv,TestAnalyticsClickhouseConfiguration,TestServeHTTP,TestTLSCABundle,TestLoad,TestMarshalYAML,TestGetConfigFile,TestStructTags,TestJSONSchema,TestTLSInsecure,TestDatabaseProtocol
