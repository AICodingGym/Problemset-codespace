#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/telemetry/telemetry_test.go 2>/dev/null || true" EXIT
git checkout b2cd6a6dd73ca91b519015fd5924fde8d17f3f06 -- internal/telemetry/telemetry_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPing_SpecifyStateDir,TestPing_Existing,TestShutdown,TestPing_Disabled,TestPing,TestNewReporter
