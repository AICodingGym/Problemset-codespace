#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_urlutils.py 2>/dev/null || true" EXIT
git checkout deeb15d6f009b3ca0c3bd503a7cef07462bd16b4 -- tests/unit/utils/test_urlutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_urlutils.py
