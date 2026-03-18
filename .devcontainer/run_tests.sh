#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/openlibrary/tests/test_lists.py 2>/dev/null || true" EXIT
git checkout 6fdbbeee4c0a7e976ff3e46fb1d36f4eb110c428 -- openlibrary/plugins/openlibrary/tests/test_lists.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/openlibrary/tests/test_lists.py
