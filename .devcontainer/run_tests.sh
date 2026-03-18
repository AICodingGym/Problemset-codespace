#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/rel_plugin_loading/subdir/inventory_plugins/notyaml.py test/units/mock/loader.py test/units/parsing/test_dataloader.py 2>/dev/null || true" EXIT
git checkout 3b823d908e8a5d17674f8c26d337d3114b7493b1 -- test/integration/targets/rel_plugin_loading/subdir/inventory_plugins/notyaml.py test/units/mock/loader.py test/units/parsing/test_dataloader.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/parsing/test_dataloader.py,test/integration/targets/rel_plugin_loading/subdir/inventory_plugins/notyaml.py,test/units/mock/loader.py
