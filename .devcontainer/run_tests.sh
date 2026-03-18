#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- model/criteria/operators_test.go 2>/dev/null || true" EXIT
git checkout dfa453cc4ab772928686838dc73d0130740f054e -- model/criteria/operators_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCriteria
