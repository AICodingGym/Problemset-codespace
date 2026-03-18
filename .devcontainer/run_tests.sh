#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/tracing/tracing_test.go 2>/dev/null || true" EXIT
git checkout 3d5a345f94c2adc8a0eaa102c189c08ad4c0f8e8 -- internal/config/config_test.go internal/tracing/tracing_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestCacheBackend,TestLogEncoding,TestMarshalYAML,Test_mustBindEnv,TestDefaultDatabaseRoot,TestAnalyticsClickhouseConfiguration,TestJSONSchema,TestDatabaseProtocol,TestGetConfigFile,TestServeHTTP,TestScheme,TestTracingExporter
