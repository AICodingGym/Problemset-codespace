#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/evaluation/legacy_evaluator_test.go 2>/dev/null || true" EXIT
git checkout db1c3b100e231c62f0c90c2ab037614f20a2a63b -- internal/server/evaluation/legacy_evaluator_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_matchesString
