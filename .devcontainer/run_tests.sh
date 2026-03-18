#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- models/library_test.go 2>/dev/null || true" EXIT
git checkout c11ba27509f733d7d280bdf661cbbe2e7a99df4c -- models/library_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFormatMaxCvssScore,TestSummaries,TestExcept,TestFilterIgnorePkgsContainer,TestLibraryScanners_Find/miss,TestCvss3Scores,TestDistroAdvisories_AppendIfMissing/duplicate_no_append,TestStorePackageStatueses,TestVulnInfo_AttackVector/3.1:N,TestPackage_FormatVersionFromTo/nfy2,TestToSortedSlice,TestCvss2Scores,TestFilterByCvssOver,TestVulnInfo_AttackVector/2.0:L,TestPackage_FormatVersionFromTo,TestMerge,TestDistroAdvisories_AppendIfMissing/append,TestVendorLink,TestPackage_FormatVersionFromTo/nfy3,TestTitles,TestPackage_FormatVersionFromTo/nfy,TestCountGroupBySeverity,TestPackage_FormatVersionFromTo/fixed,TestVulnInfo_AttackVector/3.0:N,TestLibraryScanners_Find,TestVulnInfo_AttackVector,TestSortPackageStatues,TestPackage_FormatVersionFromTo/nfy#01,TestFilterIgnoreCveIDsContainer,TestFilterIgnoreCveIDs,TestVulnInfo_AttackVector/2.0:N,TestAppendIfMissing,TestMergeNewVersion,TestFilterUnfixed,TestIsDisplayUpdatableNum,TestSourceLinks,TestLibraryScanners_Find/multi_file,TestAddBinaryName,TestMaxCvssScores,TestFindByBinName,TestSortByConfiden,TestFilterIgnorePkgs,TestMaxCvss2Scores,TestDistroAdvisories_AppendIfMissing,TestVulnInfo_AttackVector/2.0:A,TestMaxCvss3Scores,TestLibraryScanners_Find/single_file
