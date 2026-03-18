#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/config_test.go 2>/dev/null || true" EXIT
git checkout 21a935ad7886cc50c46852be21b37f363a926af0 -- config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScheme,TestValidate,TestDatabaseProtocol,TestLoad,TestServeHTTP,TestCacheBackend,TestLogEncoding
