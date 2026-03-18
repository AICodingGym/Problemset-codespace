#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/asciitable/table_test.go 2>/dev/null || true" EXIT
git checkout 46aa81b1ce96ebb4ebed2ae53fd78cd44a05da6c -- lib/asciitable/table_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFullTable,TestTruncatedTable,TestHeadlessTable
