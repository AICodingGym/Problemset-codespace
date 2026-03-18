#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- contrib/snmp2cpe/pkg/cpe/cpe_test.go 2>/dev/null || true" EXIT
git checkout 01441351c3407abfc21c48a38e28828e1b504e0c -- contrib/snmp2cpe/pkg/cpe/cpe_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestConvert,TestConvert/FortiSwitch-108E
