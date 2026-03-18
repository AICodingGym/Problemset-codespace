#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_qtargs.py 2>/dev/null || true" EXIT
git checkout 2e961080a85d660148937ee8f0f6b3445a8f2c01 -- tests/unit/config/test_qtargs.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_qtargs.py
