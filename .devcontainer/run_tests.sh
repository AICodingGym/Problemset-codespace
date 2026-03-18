#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/utils_test.go 2>/dev/null || true" EXIT
git checkout 89f0432ad5dc70f1f6a30ec3a8363d548371a718 -- lib/utils/utils_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSlice,TestReadAtMost,TestEscapeControl,TestAllowNewlines,TestConsolefLongComponent
