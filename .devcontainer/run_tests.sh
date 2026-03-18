#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_table_of_contents.py 2>/dev/null || true" EXIT
git checkout 77c16d530b4d5c0f33d68bead2c6b329aee9b996 -- openlibrary/plugins/upstream/tests/test_table_of_contents.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_table_of_contents.py
