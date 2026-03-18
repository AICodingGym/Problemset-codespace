#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- gost/debian_test.go models/vulninfos_test.go oval/util_test.go 2>/dev/null || true" EXIT
git checkout 9a32a94806b54141b7ff12503c48da680ebcf199 -- gost/debian_test.go models/vulninfos_test.go oval/util_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDebian_Supported/9_is_supported,TestDebian_Supported/empty_string_is_not_supported_yet,TestDebian_Supported/10_is_supported,TestDebian_Supported/11_is_not_supported_yet,TestDebian_Supported/8_is_supported,TestParseCwe,TestSetPackageStates,TestDebian_Supported
