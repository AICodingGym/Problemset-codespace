#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/misc/test_sql.py 2>/dev/null || true" EXIT
git checkout fcfa069a06ade76d91bac38127f3235c13d78eb1 -- tests/unit/misc/test_sql.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_sql.py
