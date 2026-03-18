#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/module_utils_Ansible.Basic/library/ansible_basic_tests.ps1 test/lib/ansible_test/_data/sanity/pylint/plugins/deprecated.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/main.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/ps_argspec.ps1 test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/schema.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/utils.py test/lib/ansible_test/_internal/sanity/pylint.py test/lib/ansible_test/_internal/sanity/validate_modules.py test/units/module_utils/basic/test_deprecate_warn.py 2>/dev/null || true" EXIT
git checkout ea04e0048dbb3b63f876aad7020e1de8eee9f362 -- test/integration/targets/module_utils_Ansible.Basic/library/ansible_basic_tests.ps1 test/lib/ansible_test/_data/sanity/pylint/plugins/deprecated.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/main.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/ps_argspec.ps1 test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/schema.py test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/utils.py test/lib/ansible_test/_internal/sanity/pylint.py test/lib/ansible_test/_internal/sanity/validate_modules.py test/units/module_utils/basic/test_deprecate_warn.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/main.py,test/units/module_utils/basic/test_deprecate_warn.py,test/lib/ansible_test/_internal/sanity/validate_modules.py,test/lib/ansible_test/_internal/sanity/pylint.py,test/lib/ansible_test/_data/sanity/pylint/plugins/deprecated.py,test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/schema.py,test/lib/ansible_test/_data/sanity/validate-modules/validate_modules/utils.py
