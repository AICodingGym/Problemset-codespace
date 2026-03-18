#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/redhatbase_test.go 2>/dev/null || true" EXIT
git checkout 0ec945d0510cdebf92cdd8999f94610772689f14 -- scanner/redhatbase_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_redhatBase_parseInstalledPackagesLine/not_standard_rpm_style_source_package,Test_redhatBase_parseInstalledPackagesLine/release_is_empty,Test_redhatBase_parseInstalledPackagesLine/not_standard_rpm_style_source_package_2,Test_redhatBase_parseInstalledPackagesLine,Test_redhatBase_parseInstalledPackagesLine/not_standard_rpm_style_source_package_3,Test_redhatBase_parseInstalledPackagesLine/release_is_empty_2
