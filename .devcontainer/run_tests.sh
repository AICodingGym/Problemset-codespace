#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- gost/debian_test.go models/vulninfos_test.go 2>/dev/null || true" EXIT
git checkout e4728e388120b311c4ed469e4f942e0347a2689b -- gost/debian_test.go models/vulninfos_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDebian_detect,TestDebian_Supported,TestUbuntu_Supported,TestDebian_isKernelSourcePackage,TestParseCwe,TestUbuntuConvertToModel,Test_detect,TestCvss3Scores,TestDebian_CompareSeverity,TestUbuntu_isKernelSourcePackage,TestDebian_ConvertToModel
