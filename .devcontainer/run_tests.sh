#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/oci/file_test.go 2>/dev/null || true" EXIT
git checkout b22f5f02e40b225b6b93fff472914973422e97c6 -- internal/oci/file_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestStore_Fetch,TestParseReference,TestStore_Fetch_InvalidMediaType,TestStore_List,TestStore_Copy,TestFile,TestStore_Build
