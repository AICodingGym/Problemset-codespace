#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/library/setup_collections.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_api.py 2>/dev/null || true" EXIT
git checkout de5858f48dc9e1ce9117034e0d7e76806f420ca8 -- test/integration/targets/ansible-galaxy-collection/library/setup_collections.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_api.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/integration/targets/ansible-galaxy-collection/library/setup_collections.py,test/units/galaxy/test_api.py
