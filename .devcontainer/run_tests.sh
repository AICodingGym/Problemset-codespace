#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/backend/report_test.go 2>/dev/null || true" EXIT
git checkout b4e7cd3a5e246736d3fe8d6886af55030b232277 -- lib/backend/report_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestReporterTopRequestsLimit,TestBuildKeyLabel,TestInit,TestParams
