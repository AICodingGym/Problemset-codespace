#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_addbook.py 2>/dev/null || true" EXIT
git checkout 89e4b4431fe7506c365a6f6eb6f6d048d04c044c -- openlibrary/plugins/upstream/tests/test_addbook.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_addbook.py
