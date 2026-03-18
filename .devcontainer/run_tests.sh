#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/iptables/tasks/chain_management.yml test/units/modules/test_iptables.py 2>/dev/null || true" EXIT
git checkout a1569ea4ca6af5480cf0b7b3135f5e12add28a44 -- test/integration/targets/iptables/tasks/chain_management.yml test/units/modules/test_iptables.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_iptables.py
