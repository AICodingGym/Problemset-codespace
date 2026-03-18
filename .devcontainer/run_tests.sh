#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/collections/collection_root_user/ansible_collections/testns/testbroken/plugins/filter/broken_filter.py test/units/plugins/action/test_action.py 2>/dev/null || true" EXIT
git checkout 984216f52e76b904e5b0fa0fb956ab4f1e0a7751 -- test/integration/targets/collections/collection_root_user/ansible_collections/testns/testbroken/plugins/filter/broken_filter.py test/units/plugins/action/test_action.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/integration/targets/collections/collection_root_user/ansible_collections/testns/testbroken/plugins/filter/broken_filter.py,test/units/plugins/action/test_action.py
