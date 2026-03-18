#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_table_of_contents.py 2>/dev/null || true" EXIT
git checkout e1e502986a3b003899a8347ac8a7ff7b08cbfc39 -- openlibrary/plugins/upstream/tests/test_table_of_contents.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_table_of_contents.py
