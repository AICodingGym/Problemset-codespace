#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/audit/types_test.go 2>/dev/null || true" EXIT
git checkout 1dceb5edf3fa8f39495b939ef9cc0c3dd38fa17d -- internal/server/audit/types_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestVariant,TestDistribution,TestNamespace,TestSegment,TestMarshalLogObject,TestConstraint,TestFlagWithDefaultVariant,TestFlag,TestRollout,TestChecker,TestRule
