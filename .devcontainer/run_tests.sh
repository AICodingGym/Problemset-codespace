#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- oval/util_test.go 2>/dev/null || true" EXIT
git checkout 17ae386d1e185ba742eea4668ca77642e22b54c4 -- oval/util_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestIsOvalDefAffected,Test_lessThan/only_ovalmodels.Package_has_underscoreMinorversion.,Test_ovalResult_Sort/already_sorted,TestPackNamesOfUpdate,Test_ovalResult_Sort,Test_lessThan/neither_newVer_nor_ovalmodels.Package_have_underscoreMinorversion.,Test_lessThan,Test_ovalResult_Sort/sort,TestParseCvss3,Test_centOSVersionToRHEL/noop,TestPackNamesOfUpdateDebian,Test_lessThan/newVer_and_ovalmodels.Package_both_have_underscoreMinorversion.,Test_centOSVersionToRHEL,TestUpsert,TestDefpacksToPackStatuses,Test_lessThan/only_newVer_has_underscoreMinorversion.,TestParseCvss2,Test_centOSVersionToRHEL/remove_centos.,Test_centOSVersionToRHEL/remove_minor
