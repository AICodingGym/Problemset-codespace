#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/lookup/test_env.py 2>/dev/null || true" EXIT
git checkout e0c91af45fa9af575d10fd3e724ebc59d2b2d6ac -- test/units/plugins/lookup/test_env.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/lookup/test_env.py
