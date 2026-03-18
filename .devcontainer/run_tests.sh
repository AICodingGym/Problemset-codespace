#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-galaxy-collection-cli/aliases test/integration/targets/ansible-galaxy-collection-cli/files/expected.txt test/integration/targets/ansible-galaxy-collection-cli/files/expected_full_manifest.txt test/integration/targets/ansible-galaxy-collection-cli/files/full_manifest_galaxy.yml test/integration/targets/ansible-galaxy-collection-cli/files/galaxy.yml test/integration/targets/ansible-galaxy-collection-cli/files/make_collection_dir.py test/integration/targets/ansible-galaxy-collection-cli/tasks/main.yml test/integration/targets/ansible-galaxy-collection-cli/tasks/manifest.yml test/units/galaxy/test_collection.py 2>/dev/null || true" EXIT
git checkout d2f80991180337e2be23d6883064a67dcbaeb662 -- test/integration/targets/ansible-galaxy-collection-cli/aliases test/integration/targets/ansible-galaxy-collection-cli/files/expected.txt test/integration/targets/ansible-galaxy-collection-cli/files/expected_full_manifest.txt test/integration/targets/ansible-galaxy-collection-cli/files/full_manifest_galaxy.yml test/integration/targets/ansible-galaxy-collection-cli/files/galaxy.yml test/integration/targets/ansible-galaxy-collection-cli/files/make_collection_dir.py test/integration/targets/ansible-galaxy-collection-cli/tasks/main.yml test/integration/targets/ansible-galaxy-collection-cli/tasks/manifest.yml test/units/galaxy/test_collection.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py,test/integration/targets/ansible-galaxy-collection-cli/files/make_collection_dir.py
