#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/telemetry/telemetry_test.go 2>/dev/null || true" EXIT
git checkout 2eac0df47b5ecc8bb05002d80383ceb08ab3620a -- internal/telemetry/telemetry_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPing_Existing,TestPing,TestPing_SpecifyStateDir
