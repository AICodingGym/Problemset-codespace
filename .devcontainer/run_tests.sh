#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go 2>/dev/null || true" EXIT
git checkout c1fd7a81ef9f23e742501bfb26d914eb683262aa -- internal/config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad
