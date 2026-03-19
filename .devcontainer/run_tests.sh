#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- gost/gost_test.go oval/util_test.go 2>/dev/null || true" EXIT
git checkout ef2be3d6ea4c0a13674aaab08b182eca4e2b9a17 -- gost/gost_test.go oval/util_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_rhelDownStreamOSVersionToRHEL,TestPackNamesOfUpdate,TestUpsert,Test_ovalResult_Sort,TestIsOvalDefAffected,TestParseCvss2,Test_lessThan,TestParseCvss3,TestDefpacksToPackStatuses,TestSUSE_convertToModel
