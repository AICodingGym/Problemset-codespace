#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/tasks/download.yml test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/integration/targets/ansible-galaxy-collection/tasks/upgrade.yml test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_collection_install.py 2>/dev/null || true" EXIT
git checkout 9759e0ca494de1fd5fc2df2c5d11c57adbe6007c -- test/integration/targets/ansible-galaxy-collection/tasks/download.yml test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/integration/targets/ansible-galaxy-collection/tasks/upgrade.yml test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_collection_install.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection_install.py
