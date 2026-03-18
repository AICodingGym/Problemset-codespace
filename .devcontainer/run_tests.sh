#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/opensubsonic_test.go 2>/dev/null || true" EXIT
git checkout 23bebe4e06124becf1000e88472ae71a6ca7de4c -- server/subsonic/opensubsonic_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi
