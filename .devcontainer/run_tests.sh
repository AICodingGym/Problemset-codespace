#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/ofrep/evaluation_test.go internal/server/ofrep/extensions_test.go internal/server/ofrep/middleware_test.go 2>/dev/null || true" EXIT
git checkout 3b2c25ee8a3ac247c3fad13ad8d64ace34ec8ee7 -- internal/server/ofrep/evaluation_test.go internal/server/ofrep/extensions_test.go internal/server/ofrep/middleware_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEvaluateFlag_Failure,TestEvaluateFlag_Success,TestGetProviderConfiguration,TestEvaluateBulkSuccess
