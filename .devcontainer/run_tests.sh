#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/os_test.go gost/ubuntu_test.go 2>/dev/null || true" EXIT
git checkout ad2edbb8448e2c41a097f1c0b52696c0f6c5924d -- config/os_test.go gost/ubuntu_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestUbuntuConvertToModel/gost_Ubuntu.ConvertToModel,TestDebian_Supported/8_is_supported,TestUbuntu_Supported/16.04_is_supported,TestDebian_Supported/11_is_supported,TestUbuntu_Supported/20.04_is_supported,TestUbuntu_Supported,Test_detect/linux-meta,Test_detect,TestUbuntu_Supported/14.04_is_supported,TestDebian_Supported/9_is_supported,Test_detect/linux-signed,Test_detect/unfixed,TestDebian_Supported/empty_string_is_not_supported_yet,TestParseCwe,TestUbuntuConvertToModel,TestDebian_Supported,Test_detect/fixed,TestSetPackageStates,TestUbuntu_Supported/empty_string_is_not_supported_yet,TestDebian_Supported/10_is_supported,TestUbuntu_Supported/20.10_is_supported,TestUbuntu_Supported/21.04_is_supported,TestUbuntu_Supported/18.04_is_supported,TestDebian_Supported/12_is_not_supported_yet
