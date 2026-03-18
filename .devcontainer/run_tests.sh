#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/gathering_facts/runme.sh test/integration/targets/gathering_facts/test_module_defaults.yml test/integration/targets/package/tasks/main.yml test/integration/targets/service/tasks/tests.yml test/units/plugins/action/test_gather_facts.py 2>/dev/null || true" EXIT
git checkout 5640093f1ca63fd6af231cc8a7fb7d40e1907b8c -- test/integration/targets/gathering_facts/runme.sh test/integration/targets/gathering_facts/test_module_defaults.yml test/integration/targets/package/tasks/main.yml test/integration/targets/service/tasks/tests.yml test/units/plugins/action/test_gather_facts.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/action/test_gather_facts.py
