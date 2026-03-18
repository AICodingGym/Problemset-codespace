#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/config_test.go internal/telemetry/telemetry_test.go 2>/dev/null || true" EXIT
git checkout 65581fef4aa807540cb933753d085feb0d7e736f -- config/config_test.go internal/telemetry/telemetry_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestReport,TestReport_SpecifyStateDir,TestServeHTTP,TestValidate,TestScheme,TestReport_Disabled,TestReporterClose,TestReport_Existing,TestNewReporter,TestLoad
