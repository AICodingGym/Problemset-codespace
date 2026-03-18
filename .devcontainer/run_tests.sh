#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/test_iptables.py 2>/dev/null || true" EXIT
git checkout be59caa59bf47ca78a4760eb7ff38568372a8260 -- test/units/modules/test_iptables.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_iptables.py
