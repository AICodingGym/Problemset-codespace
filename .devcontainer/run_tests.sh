#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_debug.py 2>/dev/null || true" EXIT
git checkout e64622cd2df5b521342cf4a62e0d4cb8f8c9ae5a -- tests/unit/utils/test_debug.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_debug.py
