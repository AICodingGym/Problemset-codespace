#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/icx/fixtures/icx_ping_ping_10.255.255.250_count_2 test/units/modules/network/icx/fixtures/icx_ping_ping_10.255.255.250_count_2_timeout_45 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_count_2 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_count_5_ttl_70 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_size_10001 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_ttl_300 test/units/modules/network/icx/test_icx_ping.py 2>/dev/null || true" EXIT
git checkout 622a493ae03bd5e5cf517d336fc426e9d12208c7 -- test/units/modules/network/icx/fixtures/icx_ping_ping_10.255.255.250_count_2 test/units/modules/network/icx/fixtures/icx_ping_ping_10.255.255.250_count_2_timeout_45 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_count_2 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_count_5_ttl_70 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_size_10001 test/units/modules/network/icx/fixtures/icx_ping_ping_8.8.8.8_ttl_300 test/units/modules/network/icx/test_icx_ping.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/icx/test_icx_ping.py
