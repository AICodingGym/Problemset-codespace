#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/net_tools/nios/test_nios_fixed_address.py 2>/dev/null || true" EXIT
git checkout 189fcb37f973f0b1d52b555728208eeb9a6fce83 -- test/units/modules/net_tools/nios/test_nios_fixed_address.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/net_tools/nios/test_nios_fixed_address.py
