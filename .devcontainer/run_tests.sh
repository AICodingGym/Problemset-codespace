#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_load_book.py 2>/dev/null || true" EXIT
git checkout 53d376b148897466bb86d5accb51912bbbe9a8ed -- openlibrary/catalog/add_book/tests/test_load_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_load_book.py
