#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_urlutils.py 2>/dev/null || true" EXIT
git checkout e34dfc68647d087ca3175d9ad3f023c30d8c9746 -- tests/unit/utils/test_urlutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_urlutils.py
