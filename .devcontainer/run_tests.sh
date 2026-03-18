#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/delegate_to/runme.sh test/integration/targets/delegate_to/test_random_delegate_to_with_loop.yml test/integration/targets/delegate_to/test_random_delegate_to_without_loop.yml test/units/executor/test_task_executor.py 2>/dev/null || true" EXIT
git checkout 42355d181a11b51ebfc56f6f4b3d9c74e01cb13b -- test/integration/targets/delegate_to/runme.sh test/integration/targets/delegate_to/test_random_delegate_to_with_loop.yml test/integration/targets/delegate_to/test_random_delegate_to_without_loop.yml test/units/executor/test_task_executor.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/executor/test_task_executor.py
