#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/catalog/test_get_ia.py 2>/dev/null || true" EXIT
git checkout fad4a40acf5ff5f06cd7441a5c7baf41a7d81fe4 -- openlibrary/tests/catalog/test_get_ia.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/catalog/test_get_ia.py
