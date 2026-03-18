#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/playbook/runme.sh test/units/playbook/test_play.py 2>/dev/null || true" EXIT
git checkout cd473dfb2fdbc97acf3293c134b21cbbcfa89ec3 -- test/integration/targets/playbook/runme.sh test/units/playbook/test_play.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/playbook/test_play.py
