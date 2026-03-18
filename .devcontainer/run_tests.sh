#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/asciitable/table_test.go tool/tsh/tsh_test.go 2>/dev/null || true" EXIT
git checkout ad41b3c15414b28a6cec8c25424a19bfa7abd0e9 -- lib/asciitable/table_test.go tool/tsh/tsh_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMakeTableWithTruncatedColumn,TestFullTable,TestHeadlessTable,TestMakeTableWithTruncatedColumn/column3,TestTruncatedTable,TestMakeTableWithTruncatedColumn/column2,TestMakeTableWithTruncatedColumn/no_column_match
