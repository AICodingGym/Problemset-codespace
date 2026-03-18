#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/metadata/metadata_internal_test.go 2>/dev/null || true" EXIT
git checkout 56303cde23a4122d2447cbb266f942601a78d7e4 -- scanner/metadata/metadata_internal_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMetadata
