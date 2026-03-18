#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/uri/tasks/main.yml test/units/module_utils/urls/fixtures/multipart.txt test/units/module_utils/urls/test_prepare_multipart.py 2>/dev/null || true" EXIT
git checkout 106909db8b730480615f4a33de0eb5b710944e78 -- test/integration/targets/uri/tasks/main.yml test/units/module_utils/urls/fixtures/multipart.txt test/units/module_utils/urls/test_prepare_multipart.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/urls/test_prepare_multipart.py
