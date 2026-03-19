#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/os_test.go 2>/dev/null || true" EXIT
git checkout e1df74cbc1a1d1889428b3333a3b2405c4651993 -- config/os_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_getAmazonLinuxVersion/2023.3.20240312,Test_getAmazonLinuxVersion
