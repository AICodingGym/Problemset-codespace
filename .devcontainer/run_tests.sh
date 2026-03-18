#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/sql/segment_test.go 2>/dev/null || true" EXIT
git checkout b2393f07d893024ab1e47ea2081e0289e1f9d56f -- internal/storage/sql/segment_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDBTestSuite
