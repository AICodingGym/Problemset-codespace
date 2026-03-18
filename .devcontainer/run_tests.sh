#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/native/native_test.go 2>/dev/null || true" EXIT
git checkout 2be514d3c33b0ae9188e11ac9975485c853d98bb -- lib/auth/native/native_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPrecomputeMode,TestNative
