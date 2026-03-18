#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-doc/broken-docs/collections/ansible_collections/testns/testcol/plugins/lookup/noop.py test/lib/ansible_test/_util/controller/sanity/pylint/plugins/unwanted.py test/support/integration/plugins/module_utils/network/common/utils.py test/support/network-integration/collections/ansible_collections/ansible/netcommon/plugins/module_utils/network/common/utils.py test/units/executor/module_common/test_recursive_finder.py test/units/module_utils/common/test_collections.py test/units/module_utils/conftest.py test/units/modules/conftest.py 2>/dev/null || true" EXIT
git checkout 379058e10f3dbc0fdcaf80394bd09b18927e7d33 -- test/integration/targets/ansible-doc/broken-docs/collections/ansible_collections/testns/testcol/plugins/lookup/noop.py test/lib/ansible_test/_util/controller/sanity/pylint/plugins/unwanted.py test/support/integration/plugins/module_utils/network/common/utils.py test/support/network-integration/collections/ansible_collections/ansible/netcommon/plugins/module_utils/network/common/utils.py test/units/executor/module_common/test_recursive_finder.py test/units/module_utils/common/test_collections.py test/units/module_utils/conftest.py test/units/modules/conftest.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/lib/ansible_test/_util/controller/sanity/pylint/plugins/unwanted.py,test/units/modules/conftest.py,test/units/module_utils/conftest.py,test/integration/targets/ansible-doc/broken-docs/collections/ansible_collections/testns/testcol/plugins/lookup/noop.py,test/units/executor/module_common/test_recursive_finder.py,test/support/network-integration/collections/ansible_collections/ansible/netcommon/plugins/module_utils/network/common/utils.py,test/support/integration/plugins/module_utils/network/common/utils.py,test/units/module_utils/common/test_collections.py
