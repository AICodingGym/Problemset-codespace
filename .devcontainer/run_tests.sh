#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- utils/gg/gg_test.go 2>/dev/null || true" EXIT
git checkout bf2bcb12799b21069f137749e0c331f761d1f693 -- utils/gg/gg_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestGG
