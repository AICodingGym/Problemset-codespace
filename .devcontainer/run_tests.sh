#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/auth_test.go 2>/dev/null || true" EXIT
git checkout 31799662706fedddf5bcc1a76b50409d1f91d327 -- server/auth_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestServer
