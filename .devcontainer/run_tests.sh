#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- models/scanresults_test.go scan/freebsd_test.go 2>/dev/null || true" EXIT
git checkout 4b680b996061044e93ef5977a081661665d3360a -- models/scanresults_test.go scan/freebsd_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParseIp,TestSplitAptCachePolicy,TestIsRunningKernelRedHatLikeLinux,TestDecorateCmd,TestParseDockerPs,TestParsePkgVersion,TestParseChangelog/realvnc-vnc-server,TestGetCveIDsFromChangelog,TestParseApkInfo,TestParseLxdPs,TestIsDisplayUpdatableNum,TestScanUpdatablePackages,TestIsRunningKernelSUSE,Test_base_parseLsProcExe,TestGetChangelogCache,Test_base_parseLsOf,TestParseAptCachePolicy,TestParseBlock,TestParseInstalledPackagesLinesRedhat,Test_base_parseLsOf/lsof,TestParseSystemctlStatus,TestParseChangelog,TestParseYumCheckUpdateLinesAmazon,TestParseCheckRestart,TestParseApkVersion,TestParseIfconfig,TestParseNeedsRestarting,TestViaHTTP,TestParsePkgInfo,Test_debian_parseGetPkgName/success,TestParseOSRelease,Test_base_parseGrepProcMap,TestParseScanedPackagesLineRedhat,TestGetUpdatablePackNames,Test_base_parseGrepProcMap/systemd,TestParseChangelog/vlc,Test_base_parseLsProcExe/systemd,TestIsAwsInstanceID,TestParseYumCheckUpdateLines,TestScanUpdatablePackage,Test_debian_parseGetPkgName,TestSplitIntoBlocks,TestParseYumCheckUpdateLine
