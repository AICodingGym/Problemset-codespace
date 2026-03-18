#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go test/api.sh test/config/test-with-auth.yml 2>/dev/null || true" EXIT
git checkout a42d38a1bb1df267c53d9d4a706cf34825ae3da9 -- internal/config/config_test.go test/api.sh test/config/test-with-auth.yml

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestLogEncoding,TestServeHTTP,Test_mustBindEnv,TestDatabaseProtocol,TestScheme,TestCacheBackend,TestJSONSchema
