#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/nxos/fixtures/nxos_vrf_af/config.cfg test/units/modules/network/nxos/test_nxos_vrf_af.py 2>/dev/null || true" EXIT
git checkout 77658704217d5f166404fc67997203c25381cb6e -- test/units/modules/network/nxos/fixtures/nxos_vrf_af/config.cfg test/units/modules/network/nxos/test_nxos_vrf_af.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/nxos/test_nxos_vrf_af.py
