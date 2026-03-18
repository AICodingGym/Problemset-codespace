#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection/files/build_bad_tar.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/units/galaxy/test_collection.py 2>/dev/null || true" EXIT
git checkout a20a52701402a12f91396549df04ac55809f68e9 -- test/integration/targets/ansible-galaxy-collection/files/build_bad_tar.py test/integration/targets/ansible-galaxy-collection/tasks/install.yml test/units/galaxy/test_collection.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py,test/integration/targets/ansible-galaxy-collection/files/build_bad_tar.py
