#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/oci/file_test.go 2>/dev/null || true" EXIT
git checkout 6fd0f9e2587f14ac1fdd1c229f0bcae0468c8daa -- internal/config/config_test.go internal/oci/file_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLogEncoding,TestMarshalYAML,TestNewStore,TestStore_Fetch,TestLoad,TestServeHTTP,TestTracingExporter,Test_mustBindEnv,TestDatabaseProtocol,TestScheme,TestJSONSchema,TestStore_Fetch_InvalidMediaType,TestCacheBackend
