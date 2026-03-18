#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- utils/cache/simple_cache_test.go 2>/dev/null || true" EXIT
git checkout 29b7b740ce469201af0a0510f3024adc93ef4c8e -- utils/cache/simple_cache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCache
