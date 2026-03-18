#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/fs/object/file_test.go internal/storage/fs/object/fileinfo_test.go internal/storage/fs/snapshot_test.go internal/storage/fs/store_test.go 2>/dev/null || true" EXIT
git checkout 05d7234fa582df632f70a7cd10194d61bd7043b9 -- internal/storage/fs/object/file_test.go internal/storage/fs/object/fileinfo_test.go internal/storage/fs/snapshot_test.go internal/storage/fs/store_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestNewFile,TestRemapScheme,TestFSWithoutIndex,TestSupportedSchemes,TestFileInfoIsDir,TestFileInfo,TestGetVersion
