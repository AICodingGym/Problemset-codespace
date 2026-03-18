#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/connection_winrm/tests.yml test/units/plugins/shell/test_powershell.py 2>/dev/null || true" EXIT
git checkout b5e0293645570f3f404ad1dbbe5f006956ada0df -- test/integration/targets/connection_winrm/tests.yml test/units/plugins/shell/test_powershell.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/shell/test_powershell.py
