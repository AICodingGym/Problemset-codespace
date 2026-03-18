#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_lists_model.py 2>/dev/null || true" EXIT
git checkout d109cc7e6e161170391f98f9a6fa1d02534c18e4 -- openlibrary/tests/core/test_lists_model.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_lists_model.py
