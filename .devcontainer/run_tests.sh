#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/media_streamer_Internal_test.go 2>/dev/null || true" EXIT
git checkout 6c6223f2f9db2c8c253e0d40a192e3519c9037d1 -- core/media_streamer_Internal_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCore
