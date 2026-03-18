#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_table_of_contents.py 2>/dev/null || true" EXIT
git checkout 09865f5fb549694d969f0a8e49b9d204ef1853ca -- openlibrary/plugins/upstream/tests/test_table_of_contents.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_table_of_contents.py
