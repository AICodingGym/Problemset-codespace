#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout d966559200183b713cdf3ea5007a7e0ba86a5afb -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestTracingExporter,TestLoad,TestLogEncoding,TestServeHTTP,TestDefaultDatabaseRoot,TestMarshalYAML,TestDatabaseProtocol,TestCacheBackend,TestGetConfigFile,TestStructTags,TestScheme,TestJSONSchema,Test_mustBindEnv,TestAnalyticsClickhouseConfiguration
