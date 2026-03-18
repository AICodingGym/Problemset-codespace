#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- .github/workflows/test.yml internal/storage/sql/db_test.go 2>/dev/null || true" EXIT
git checkout 9f8127f225a86245fa35dca4885c2daef824ee55 -- .github/workflows/test.yml internal/storage/sql/db_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMigratorExpectedVersions,TestOpen,TestMigratorRun,TestDBTestSuite,TestParse,TestMigratorRun_NoChange
