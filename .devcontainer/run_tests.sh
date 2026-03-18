#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/events/diode_test.go server/events/sse_test.go server/subsonic/middlewares_test.go 2>/dev/null || true" EXIT
git checkout b65e76293a917ee2dfc5d4b373b1c62e054d0dca -- server/events/diode_test.go server/events/sse_test.go server/subsonic/middlewares_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi,TestEvents
