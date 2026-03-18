#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/redhatbase_test.go 2>/dev/null || true" EXIT
git checkout bff6b7552370b55ff76d474860eead4ab5de785a -- scanner/redhatbase_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_redhatBase_parseUpdatablePacksLines/amazon,Test_redhatBase_parseUpdatablePacksLine,Test_redhatBase_parseUpdatablePacksLine/centos_7.0:_"shadow-utils"_"2"_"4.1.5.1_24.el7"_"rhui-REGION-rhel-server-releases",Test_redhatBase_parseUpdatablePacksLines,Test_redhatBase_parseUpdatablePacksLines/centos,Test_redhatBase_parseUpdatablePacksLine/amazon_2023:_Is_this_ok_[y/N]:_"dnf"_"0"_"4.14.0"_"1.amzn2023.0.6"_"amazonlinux",Test_redhatBase_parseUpdatablePacksLine/centos_7.0:_"zlib"_"0"_"1.2.7"_"17.el7"_"rhui-REGION-rhel-server-releases"
