#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/eric_eccli/__init__.py test/units/modules/network/eric_eccli/eccli_module.py test/units/modules/network/eric_eccli/fixtures/configure_terminal test/units/modules/network/eric_eccli/fixtures/show_version test/units/modules/network/eric_eccli/test_eccli_command.py 2>/dev/null || true" EXIT
git checkout eea46a0d1b99a6dadedbb6a3502d599235fa7ec3 -- test/units/modules/network/eric_eccli/__init__.py test/units/modules/network/eric_eccli/eccli_module.py test/units/modules/network/eric_eccli/fixtures/configure_terminal test/units/modules/network/eric_eccli/fixtures/show_version test/units/modules/network/eric_eccli/test_eccli_command.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/eric_eccli/test_eccli_command.py,test/units/modules/network/eric_eccli/__init__.py,test/units/modules/network/eric_eccli/eccli_module.py
