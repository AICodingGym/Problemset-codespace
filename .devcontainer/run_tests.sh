#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 381b90f718435c4694380b5fcd0d5cf8e3b5a25a -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestServeHTTP,TestTracingExporter,Test_mustBindEnv,TestCacheBackend,TestDefaultDatabaseRoot,TestLogEncoding,TestLoad,TestJSONSchema,TestScheme,TestMarshalYAML,TestDatabaseProtocol
