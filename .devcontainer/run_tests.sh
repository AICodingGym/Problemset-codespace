#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/metrics/metrics_test.go internal/tracing/tracing_test.go 2>/dev/null || true" EXIT
git checkout 2ca5dfb3513e4e786d2b037075617cccc286d5c3 -- internal/config/config_test.go internal/metrics/metrics_test.go internal/tracing/tracing_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,Test_mustBindEnv,TestCacheBackend,TestScheme,TestDatabaseProtocol,TestMarshalYAML,TestGetxporter,TestLogEncoding,TestDefaultDatabaseRoot,TestGetConfigFile,TestTracingExporter,TestServeHTTP,TestAnalyticsClickhouseConfiguration,TestJSONSchema
