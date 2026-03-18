#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_qtargs.py 2>/dev/null || true" EXIT
git checkout 1a9e74bfaf9a9db2a510dc14572d33ded6040a57 -- tests/unit/config/test_qtargs.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_qtargs.py
