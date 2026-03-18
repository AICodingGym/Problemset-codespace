#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/config/test_manager.py test/units/playbook/test_task.py 2>/dev/null || true" EXIT
git checkout f8ef34672b961a95ec7282643679492862c688ec -- test/units/config/test_manager.py test/units/playbook/test_task.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/playbook/test_task.py,test/units/config/test_manager.py
