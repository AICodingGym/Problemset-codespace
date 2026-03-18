#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/audit/checker_test.go 2>/dev/null || true" EXIT
git checkout b2170346dc37cf42fda1386cd630f24821ad2ac5 -- internal/server/audit/checker_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestChecker
