#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/test_qt_machinery.py 2>/dev/null || true" EXIT
git checkout 322834d0e6bf17e5661145c9f085b41215c280e8 -- tests/unit/test_qt_machinery.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/test_qt_machinery.py
