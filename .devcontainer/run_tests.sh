#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/filter/test_mathstuff.py 2>/dev/null || true" EXIT
git checkout 3db08adbb1cc6aa9941be5e0fc810132c6e1fa4b -- test/units/plugins/filter/test_mathstuff.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/filter/test_mathstuff.py
