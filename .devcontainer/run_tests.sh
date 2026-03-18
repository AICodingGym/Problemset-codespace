#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/fanoutbuffer/buffer_test.go 2>/dev/null || true" EXIT
git checkout bb562408da4adeae16e025be65e170959d1ec492 -- lib/utils/fanoutbuffer/buffer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCursorFinalizer,TestBasics,TestConcurrentFanout
