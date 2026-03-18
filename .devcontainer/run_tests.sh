#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/misc/test_guiprocess.py 2>/dev/null || true" EXIT
git checkout 5cef49ff3074f9eab1da6937a141a39a20828502 -- tests/unit/misc/test_guiprocess.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_guiprocess.py
