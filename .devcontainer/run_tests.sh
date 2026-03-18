#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/middlewares_test.go 2>/dev/null || true" EXIT
git checkout 09ae41a2da66264c60ef307882362d2e2d8d8b89 -- server/subsonic/middlewares_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi
