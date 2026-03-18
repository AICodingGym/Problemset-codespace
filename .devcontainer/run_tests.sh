#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/concurrentqueue/queue_test.go 2>/dev/null || true" EXIT
git checkout 629dc432eb191ca479588a8c49205debb83e80e2 -- lib/utils/concurrentqueue/queue_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestBackpressure,TestOrdering
