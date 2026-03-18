#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/events/events_test.go ui/src/common/useResourceRefresh.test.js 2>/dev/null || true" EXIT
git checkout 8383527aaba1ae8fa9765e995a71a86c129ef626 -- server/events/events_test.go ui/src/common/useResourceRefresh.test.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEvents
