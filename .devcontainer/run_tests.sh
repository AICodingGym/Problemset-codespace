#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/evaluation/legacy_evaluator_test.go rpc/flipt/validation_fuzz_test.go rpc/flipt/validation_test.go 2>/dev/null || true" EXIT
git checkout cd2f3b0a9d4d8b8a6d3d56afab65851ecdc408e8 -- internal/server/evaluation/legacy_evaluator_test.go rpc/flipt/validation_fuzz_test.go rpc/flipt/validation_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_matchesNumber,Test_matchesString
