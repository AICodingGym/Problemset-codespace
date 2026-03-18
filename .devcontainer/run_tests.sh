#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/netvisor/test_pn_user.py 2>/dev/null || true" EXIT
git checkout 5e88cd9972f10b66dd97e1ee684c910c6a2dd25e -- test/units/modules/network/netvisor/test_pn_user.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/netvisor/test_pn_user.py
