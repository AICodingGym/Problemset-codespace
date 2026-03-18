#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/templating/tasks/main.yml test/units/_internal/_yaml/__init__.py test/units/_internal/_yaml/test_dumper.py test/units/plugins/filter/test_core.py 2>/dev/null || true" EXIT
git checkout 1c06c46cc14324df35ac4f39a45fb3ccd602195d -- test/integration/targets/templating/tasks/main.yml test/units/_internal/_yaml/__init__.py test/units/_internal/_yaml/test_dumper.py test/units/plugins/filter/test_core.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/filter/test_core.py,test/units/_internal/_yaml/__init__.py,test/units/_internal/_yaml/test_dumper.py
