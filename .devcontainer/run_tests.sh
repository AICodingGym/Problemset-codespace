#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/events/dynamoevents/dynamoevents_test.go 2>/dev/null || true" EXIT
git checkout 4d0117b50dc8cdb91c94b537a4844776b224cd3d -- lib/events/dynamoevents/dynamoevents_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDateRangeGenerator,TestDynamoevents
