#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/icx/fixtures/icx_logging_config.cfg test/units/modules/network/icx/test_icx_logging.py 2>/dev/null || true" EXIT
git checkout b6290e1d156af608bd79118d209a64a051c55001 -- test/units/modules/network/icx/fixtures/icx_logging_config.cfg test/units/modules/network/icx/test_icx_logging.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/icx/test_icx_logging.py
