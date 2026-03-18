#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/grpcserver_test.go 2>/dev/null || true" EXIT
git checkout 3ff75e29fb2153a2637fe7f83e49dc04b1c99c9f -- lib/auth/grpcserver_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDeleteLastMFADevice
