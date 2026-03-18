#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- persistence/playqueue_repository_test.go utils/slice/slice_test.go 2>/dev/null || true" EXIT
git checkout 669c8f4c49a7ef51ac9a53c725097943f67219eb -- persistence/playqueue_repository_test.go utils/slice/slice_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSlice
