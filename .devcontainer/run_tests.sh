#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/responses/responses_test.go 2>/dev/null || true" EXIT
git checkout f7d4fcdcc1a59d1b4f835519efb402897757e371 -- server/subsonic/responses/responses_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApiResponses
