#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/get_url/tasks/ciphers.yml test/integration/targets/get_url/tasks/main.yml test/integration/targets/lookup_url/tasks/main.yml test/integration/targets/uri/tasks/ciphers.yml test/integration/targets/uri/tasks/main.yml test/units/module_utils/urls/test_Request.py test/units/module_utils/urls/test_fetch_url.py 2>/dev/null || true" EXIT
git checkout b8025ac160146319d2b875be3366b60c852dd35d -- test/integration/targets/get_url/tasks/ciphers.yml test/integration/targets/get_url/tasks/main.yml test/integration/targets/lookup_url/tasks/main.yml test/integration/targets/uri/tasks/ciphers.yml test/integration/targets/uri/tasks/main.yml test/units/module_utils/urls/test_Request.py test/units/module_utils/urls/test_fetch_url.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/urls/test_fetch_url.py,test/units/module_utils/urls/test_Request.py
