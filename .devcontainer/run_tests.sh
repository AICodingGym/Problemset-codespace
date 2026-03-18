#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configutils.py 2>/dev/null || true" EXIT
git checkout 5fdc83e5da6222fe61163395baaad7ae57fa2cb4 -- tests/unit/config/test_configutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configutils.py
