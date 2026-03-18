#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/utils/tests/test_dateutil.py 2>/dev/null || true" EXIT
git checkout 91efee627df01e32007abf2d6ebf73f9d9053076 -- openlibrary/utils/tests/test_dateutil.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/utils/tests/test_dateutil.py
