#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-config/files/galaxy_server.ini test/integration/targets/ansible-config/tasks/main.yml test/units/galaxy/test_collection.py test/units/galaxy/test_token.py 2>/dev/null || true" EXIT
git checkout 949c503f2ef4b2c5d668af0492a5c0db1ab86140 -- test/integration/targets/ansible-config/files/galaxy_server.ini test/integration/targets/ansible-config/tasks/main.yml test/units/galaxy/test_collection.py test/units/galaxy/test_token.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py,test/units/galaxy/test_token.py
