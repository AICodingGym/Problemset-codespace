#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/f5/fixtures/load_generic_route.json test/units/modules/network/f5/test_bigip_message_routing_route.py 2>/dev/null || true" EXIT
git checkout c1f2df47538b884a43320f53e787197793b105e8 -- test/units/modules/network/f5/fixtures/load_generic_route.json test/units/modules/network/f5/test_bigip_message_routing_route.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/f5/test_bigip_message_routing_route.py
