#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/ext/exporter_test.go internal/ext/importer_test.go internal/storage/sql/rollout_test.go internal/storage/sql/rule_test.go 2>/dev/null || true" EXIT
git checkout 524f277313606f8cd29b299617d6565c01642e15 -- internal/ext/exporter_test.go internal/ext/importer_test.go internal/storage/sql/rollout_test.go internal/storage/sql/rule_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestExport,TestImport,TestDBTestSuite
