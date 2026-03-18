#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/circular_buffer_test.go 2>/dev/null || true" EXIT
git checkout fb0ab2b9b771377a689fd0d0374777c251e58bbf -- lib/utils/circular_buffer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestChConn,TestReadAtMost,TestNewCircularBuffer,TestEscapeControl,TestSlice,TestCircularBuffer_Data,TestUtils,TestFilterAWSRoles,TestConsolefLongComponent,TestAllowNewlines
