#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/backend/pgbk/wal2json_test.go 2>/dev/null || true" EXIT
git checkout 005dcb16bacc6a5d5890c4cd302ccfd4298e275d -- lib/backend/pgbk/wal2json_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestColumn,TestMessage
