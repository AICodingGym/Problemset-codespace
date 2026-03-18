#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/server/audit/logfile/logfile_test.go 2>/dev/null || true" EXIT
git checkout b4bb5e13006a729bc0eed8fe6ea18cff54acdacb -- internal/config/config_test.go internal/server/audit/logfile/logfile_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAnalyticsClickhouseConfiguration,TestLogEncoding,TestTracingExporter,TestLoad,TestCacheBackend,TestJSONSchema,TestDatabaseProtocol,TestServeHTTP,Test_mustBindEnv,TestMarshalYAML,TestScheme,TestDefaultDatabaseRoot
