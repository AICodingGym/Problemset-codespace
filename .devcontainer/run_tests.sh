#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/test_iptables.py 2>/dev/null || true" EXIT
git checkout 83fb24b923064d3576d473747ebbe62e4535c9e3 -- test/units/modules/test_iptables.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_iptables.py
