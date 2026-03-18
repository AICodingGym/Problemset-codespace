#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/components/test_readlinecommands.py 2>/dev/null || true" EXIT
git checkout 1af602b258b97aaba69d2585ed499d95e2303ac2 -- tests/unit/components/test_readlinecommands.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/components/test_readlinecommands.py
