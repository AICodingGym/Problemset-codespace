#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/tasks/download.yml test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/units/cli/test_galaxy.py test/units/galaxy/test_collection.py 2>/dev/null || true" EXIT
git checkout ecea15c508f0e081525be036cf76bbb56dbcdd9d -- test/integration/targets/ansible-galaxy-collection/tasks/download.yml test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/units/cli/test_galaxy.py test/units/galaxy/test_collection.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py,test/units/cli/test_galaxy.py
