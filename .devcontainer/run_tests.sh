#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_db.py 2>/dev/null || true" EXIT
git checkout 5069b09e5f64428dce59b33455c8bb17fe577070 -- openlibrary/tests/core/test_db.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_db.py
