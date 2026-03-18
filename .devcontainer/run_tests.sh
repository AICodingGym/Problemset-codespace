#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/telemetry/telemetry_test.go 2>/dev/null || true" EXIT
git checkout 29d3f9db40c83434d0e3cc082af8baec64c391a9 -- internal/telemetry/telemetry_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPing_SpecifyStateDir,TestPing_Existing,TestPing
