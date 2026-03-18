#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/events/dynamoevents/dynamoevents_test.go 2>/dev/null || true" EXIT
git checkout 1316e6728a3ee2fc124e2ea0cc6a02044c87a144 -- lib/events/dynamoevents/dynamoevents_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDynamoevents,TestDateRangeGenerator
