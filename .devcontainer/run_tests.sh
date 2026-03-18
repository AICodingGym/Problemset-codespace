#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/completion/test_models.py 2>/dev/null || true" EXIT
git checkout 0fc6d1109d041c69a68a896db87cf1b8c194cef7 -- tests/unit/completion/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/completion/test_models.py
