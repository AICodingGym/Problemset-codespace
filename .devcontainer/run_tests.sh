#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/lib/ansible_test/_data/requirements/constraints.txt test/lib/ansible_test/_util/target/common/constants.py test/sanity/ignore.txt test/units/cli/galaxy/test_collection_extract_tar.py test/units/requirements.txt 2>/dev/null || true" EXIT
git checkout b2a289dcbb702003377221e25f62c8a3608f0e89 -- test/lib/ansible_test/_data/requirements/constraints.txt test/lib/ansible_test/_util/target/common/constants.py test/sanity/ignore.txt test/units/cli/galaxy/test_collection_extract_tar.py test/units/requirements.txt

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/lib/ansible_test/_util/target/common/constants.py,test/units/cli/galaxy/test_collection_extract_tar.py
