#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/config_test.go 2>/dev/null || true" EXIT
git checkout 5c7037ececb0bead0a8eb56054e224bcd7ac5922 -- config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestValidate,TestServeHTTP,TestLoad,TestLogEncoding,TestCacheBackend,TestDatabaseProtocol,TestScheme
