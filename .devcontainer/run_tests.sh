#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/responses/responses_test.go 2>/dev/null || true" EXIT
git checkout 0a650de357babdcc8ce910fe37fee84acf4ed2fe -- server/subsonic/responses/responses_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApiResponses
