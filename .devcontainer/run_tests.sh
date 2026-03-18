#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/utils/tests/test_dateutil.py 2>/dev/null || true" EXIT
git checkout bdba0af0f6cbaca8b5fc3be2a3080f38156d9c92 -- openlibrary/utils/tests/test_dateutil.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/utils/tests/test_dateutil.py
