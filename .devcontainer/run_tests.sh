#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/benchmark/linear_test.go 2>/dev/null || true" EXIT
git checkout 6eaaf3a27e64f4ef4ef855bd35d7ec338cf17460 -- lib/benchmark/linear_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestGetBenchmarkNotEvenMultiple,TestGetBenchmark,TestValidateConfig
