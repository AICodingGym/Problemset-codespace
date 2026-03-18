#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 86906cbfc3a5d3629a583f98e6301142f5f14bdb -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDefaultDatabaseRoot,TestGetConfigFile,TestAnalyticsClickhouseConfiguration,TestFindDatabaseRoot,TestDatabaseProtocol,TestTracingExporter,TestIsReadOnly,TestScheme,TestWithForwardPrefix,TestLoad,TestAuditEnabled,TestServeHTTP,TestStorageConfigInfo,TestRequiresDatabase,TestCacheBackend,TestMarshalYAML,Test_mustBindEnv,TestStructTags,TestAnalyticsPrometheusConfiguration,TestJSONSchema,TestLogEncoding
