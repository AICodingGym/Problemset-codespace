#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/schemes/tests/test_works.py 2>/dev/null || true" EXIT
git checkout 427f1f4eddfc54735ca451779d4f95bf683d1b0e -- openlibrary/plugins/worksearch/schemes/tests/test_works.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/schemes/tests/test_works.py
