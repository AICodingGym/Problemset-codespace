#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/config/files/types.env test/integration/targets/config/files/types.ini test/integration/targets/config/files/types.vars test/integration/targets/config/lookup_plugins/types.py test/integration/targets/config/type_munging.cfg test/integration/targets/config/types.yml test/units/config/test_manager.py 2>/dev/null || true" EXIT
git checkout 5f4e332e3762999d94af27746db29ff1729252c1 -- test/integration/targets/config/files/types.env test/integration/targets/config/files/types.ini test/integration/targets/config/files/types.vars test/integration/targets/config/lookup_plugins/types.py test/integration/targets/config/type_munging.cfg test/integration/targets/config/types.yml test/units/config/test_manager.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/integration/targets/config/lookup_plugins/types.py,test/units/config/test_manager.py
