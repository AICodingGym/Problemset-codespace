#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/cache/cache_test.go 2>/dev/null || true" EXIT
git checkout 15b76cada1ef29cfa56b0fba36754be36243dded -- internal/storage/cache/cache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestGetEvaluationRolloutsCached
