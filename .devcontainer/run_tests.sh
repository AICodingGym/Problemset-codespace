#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- models/scanresults_test.go 2>/dev/null || true" EXIT
git checkout e049df50fa1eecdccc5348e27845b5c783ed7c76 -- models/scanresults_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCveContents_PatchURLs,TestCveContents_UniqCweIDs,TestNewCveContentType,TestFormatMaxCvssScore,TestCveContents_SSVC,TestToSortedSlice,TestCveContents_Except,TestVulnInfos_FilterByCvssOver,TestRenameKernelSourcePackageName,Test_IsRaspbianPackage,TestAppendIfMissing,TestCveContents_Cpes,TestRemoveRaspbianPackFromResult,TestSourceLinks,TestIsDisplayUpdatableNum,TestMergeNewVersion,TestVulnInfos_FilterIgnoreCves,Test_NewPortStat,TestVulnInfos_FilterIgnorePkgs,TestScanResult_Sort,TestAddBinaryName,TestCvss3Scores,TestVulnInfo_Cvss40Scores,TestVulnInfos_FilterByConfidenceOver,TestIsKernelSourcePackage,TestVulnInfos_FilterUnfixed,TestFindByBinName,TestTitles,TestCveContents_CweIDs,TestCveContents_Sort,TestCveContent_Empty,TestCveContentTypes_Except,TestMaxCvssScores,TestCvss2Scores,TestSummaries,TestSortByConfident,TestVulnInfo_AttackVector,TestGetCveContentTypes,TestMaxCvss3Scores,TestVulnInfo_PatchStatus,TestMerge,TestMaxCvss2Scores,TestCveContents_References,TestSortPackageStatues,TestStorePackageStatuses,TestCountGroupBySeverity,TestLibraryScanners_Find,TestDistroAdvisories_AppendIfMissing,TestVulnInfo_MaxCvss40Score,TestPackage_FormatVersionFromTo
