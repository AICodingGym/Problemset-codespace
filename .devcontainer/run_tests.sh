#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/coverstore/tests/test_archive.py 2>/dev/null || true" EXIT
git checkout 30bc73a1395fba2300087c7f307e54bb5372b60a -- openlibrary/coverstore/tests/test_archive.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/coverstore/tests/test_archive.py
