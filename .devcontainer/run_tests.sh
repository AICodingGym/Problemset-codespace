#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/nxos_interfaces/tasks/main.yaml test/integration/targets/nxos_interfaces/tests/cli/deleted.yaml test/integration/targets/nxos_interfaces/tests/cli/merged.yaml test/integration/targets/nxos_interfaces/tests/cli/overridden.yaml test/integration/targets/nxos_interfaces/tests/cli/replaced.yaml test/units/modules/network/nxos/test_nxos_interfaces.py 2>/dev/null || true" EXIT
git checkout d72025be751c894673ba85caa063d835a0ad3a8c -- test/integration/targets/nxos_interfaces/tasks/main.yaml test/integration/targets/nxos_interfaces/tests/cli/deleted.yaml test/integration/targets/nxos_interfaces/tests/cli/merged.yaml test/integration/targets/nxos_interfaces/tests/cli/overridden.yaml test/integration/targets/nxos_interfaces/tests/cli/replaced.yaml test/units/modules/network/nxos/test_nxos_interfaces.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/nxos/test_nxos_interfaces.py
