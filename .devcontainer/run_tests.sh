#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_isbndb.py 2>/dev/null || true" EXIT
git checkout 8a9d9d323dfcf2a5b4f38d70b1108b030b20ebf3 -- scripts/tests/test_isbndb.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_isbndb.py
