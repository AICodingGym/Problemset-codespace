#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- models/scanresults_test.go models/vulninfos_test.go report/syslog_test.go 2>/dev/null || true" EXIT
git checkout 3c1489e588dacea455ccf4c352a3b1006902e2d4 -- models/scanresults_test.go models/vulninfos_test.go report/syslog_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLibraryScanners_Find/miss,Test_parseListenPorts/asterisk,Test_IsRaspbianPackage/nameRegExp,Test_parseListenPorts/ipv6_loopback,TestVulnInfo_AttackVector/2.0:A,TestFilterIgnoreCveIDsContainer,TestFilterIgnorePkgsContainer,TestExcept,TestPackage_FormatVersionFromTo/nfy,TestLibraryScanners_Find,TestVulnInfo_AttackVector/2.0:N,TestPackage_FormatVersionFromTo/nfy3,TestSummaries,TestFilterUnfixed,TestMaxCvss3Scores,Test_IsRaspbianPackage,TestPackage_FormatVersionFromTo,TestVulnInfo_AttackVector,TestSortPackageStatues,TestPackage_FormatVersionFromTo/nfy2,TestCvss2Scores,TestCountGroupBySeverity,TestFilterIgnoreCveIDs,TestFindByBinName,TestTitles,Test_IsRaspbianPackage/debianPackage,TestFilterByCvssOver,TestSortByConfident,Test_parseListenPorts,TestMaxCvssScores,TestVulnInfo_AttackVector/3.1:N,TestAppendIfMissing,TestMaxCvss2Scores,TestFilterIgnorePkgs,TestDistroAdvisories_AppendIfMissing/duplicate_no_append,TestAddBinaryName,Test_IsRaspbianPackage/verRegExp,TestMergeNewVersion,TestLibraryScanners_Find/single_file,Test_IsRaspbianPackage/nameList,TestIsDisplayUpdatableNum,TestFormatMaxCvssScore,TestVulnInfo_AttackVector/3.0:N,TestCvss3Scores,Test_parseListenPorts/empty,TestDistroAdvisories_AppendIfMissing/append,TestPackage_FormatVersionFromTo/fixed,TestSourceLinks,Test_parseListenPorts/normal,TestDistroAdvisories_AppendIfMissing,TestLibraryScanners_Find/multi_file,TestPackage_FormatVersionFromTo/nfy#01,TestMerge,TestToSortedSlice,TestStorePackageStatuses,TestVulnInfo_AttackVector/2.0:L
