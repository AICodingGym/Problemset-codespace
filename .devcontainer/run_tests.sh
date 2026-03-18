#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/artwork_internal_test.go 2>/dev/null || true" EXIT
git checkout 87d4db7638b37eeb754b217440ab7a372f669205 -- core/artwork_internal_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCore
