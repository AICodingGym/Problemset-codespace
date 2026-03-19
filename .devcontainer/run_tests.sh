#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scan/base_test.go 2>/dev/null || true" EXIT
git checkout edb324c3d9ec3b107bf947f00e38af99d05b3e16 -- scan/base_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_detectScanDest/single-addr,Test_detectScanDest/asterisk,Test_detectScanDest,Test_detectScanDest/dup-addr-port,Test_detectScanDest/empty,Test_detectScanDest/multi-addr
