#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/unmodifiable/store_test.go 2>/dev/null || true" EXIT
git checkout b68b8960b8a08540d5198d78c665a7eb0bea4008 -- internal/storage/unmodifiable/store_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestModificationMethods
