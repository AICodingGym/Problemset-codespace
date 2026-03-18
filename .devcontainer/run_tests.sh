#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/tasks/install_offline.yml test/integration/targets/ansible-galaxy-collection/templates/ansible.cfg.j2 test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_collection_install.py 2>/dev/null || true" EXIT
git checkout a02e22e902a69aeb465f16bf03f7f5a91b2cb828 -- test/integration/targets/ansible-galaxy-collection/tasks/install_offline.yml test/integration/targets/ansible-galaxy-collection/templates/ansible.cfg.j2 test/integration/targets/ansible-galaxy-collection/vars/main.yml test/units/galaxy/test_collection_install.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection_install.py
