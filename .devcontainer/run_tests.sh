#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- utils/cache/simple_cache_test.go 2>/dev/null || true" EXIT
git checkout 3bc9e75b2843f91f6a1e9b604e321c2bd4fd442a -- utils/cache/simple_cache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCache
