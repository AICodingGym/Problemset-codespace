#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/tests/test_worksearch.py 2>/dev/null || true" EXIT
git checkout a48fd6ba9482c527602bc081491d9e8ae6e8226c -- openlibrary/plugins/worksearch/tests/test_worksearch.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/tests/test_worksearch.py
