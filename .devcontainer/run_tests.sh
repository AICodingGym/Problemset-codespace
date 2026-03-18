#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/library/setup_collections.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/units/galaxy/test_collection.py 2>/dev/null || true" EXIT
git checkout d30fc6c0b359f631130b0e979d9a78a7b3747d48 -- test/integration/targets/ansible-galaxy-collection/library/setup_collections.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/integration/targets/ansible-galaxy-collection/tasks/main.yml test/units/galaxy/test_collection.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py,test/integration/targets/ansible-galaxy-collection/library/setup_collections.py
