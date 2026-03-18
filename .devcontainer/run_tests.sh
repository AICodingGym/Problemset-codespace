#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/catalog/test_utils.py 2>/dev/null || true" EXIT
git checkout d8162c226a9d576f094dc1830c4c1ffd0be2dd17 -- openlibrary/tests/catalog/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/catalog/test_utils.py
