#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- model/criteria/criteria_suite_test.go model/criteria/criteria_test.go model/criteria/operators_test.go 2>/dev/null || true" EXIT
git checkout 3972616585e82305eaf26aa25697b3f5f3082288 -- model/criteria/criteria_suite_test.go model/criteria/criteria_test.go model/criteria/operators_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCriteria
