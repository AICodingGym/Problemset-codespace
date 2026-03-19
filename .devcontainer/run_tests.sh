#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- detector/vuls2/db_test.go 2>/dev/null || true" EXIT
git checkout e52fa8d6ed1d23e36f2a86e5d3efe9aa057a1b0d -- detector/vuls2/db_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_shouldDownload/schema_version_mismatch,_but_skip_update,Test_shouldDownload,Test_shouldDownload/schema_version_mismatch
