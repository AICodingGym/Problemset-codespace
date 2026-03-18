#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout 292fdaca9be39e6a921aaa8874c011d0fdd3e874 -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestJSONSchema,TestCacheBackend,TestLoad,TestScheme,TestLogEncoding,TestDatabaseProtocol,TestServeHTTP
