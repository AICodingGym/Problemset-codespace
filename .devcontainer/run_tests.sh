#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- gost/debian_test.go gost/ubuntu_test.go models/packages_test.go scanner/debian_test.go 2>/dev/null || true" EXIT
git checkout e1fab805afcfc92a2a615371d0ec1e667503c254 -- gost/debian_test.go gost/ubuntu_test.go models/packages_test.go scanner/debian_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDebian_Supported,TestNewCveContentType,TestRemoveRaspbianPackFromResult,TestMerge,Test_debian_parseInstalledPackages,TestFormatMaxCvssScore,TestDebian_ConvertToModel,TestIsDisplayUpdatableNum,TestDebian_detect,TestSortByConfident,TestLibraryScanners_Find,TestToSortedSlice,TestMaxCvssScores,TestStorePackageStatuses,Test_NewPortStat,TestVulnInfos_FilterIgnoreCves,TestSortPackageStatues,TestVulnInfo_PatchStatus,TestVulnInfos_FilterByConfidenceOver,TestCvss2Scores,TestFindByBinName,Test_IsRaspbianPackage,TestUbuntu_Supported,TestDebian_CompareSeverity,Test_detect,TestVulnInfos_FilterIgnorePkgs,TestUbuntuConvertToModel,TestPackage_FormatVersionFromTo,TestTitles,TestSourceLinks,TestAppendIfMissing,TestIsKernelSourcePackage,TestSummaries,TestMaxCvss2Scores,TestVulnInfos_FilterByCvssOver,TestScanResult_Sort,TestCvss3Scores,TestExcept,TestDistroAdvisories_AppendIfMissing,TestVulnInfos_FilterUnfixed,TestAddBinaryName,TestGetCveContentTypes,TestCveContents_Sort,TestVulnInfo_AttackVector,TestParseCwe,TestRenameKernelSourcePackageName,TestMaxCvss3Scores,TestMergeNewVersion,TestCountGroupBySeverity
