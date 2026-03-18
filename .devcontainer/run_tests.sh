#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/fs/git/source_test.go 2>/dev/null || true" EXIT
git checkout 5aef5a14890aa145c22d864a834694bae3a6f112 -- internal/storage/fs/git/source_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_SourceSelfSignedSkipTLS
