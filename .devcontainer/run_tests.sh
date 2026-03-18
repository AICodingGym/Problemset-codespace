#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/redhatbase_test.go 2>/dev/null || true" EXIT
git checkout 2c84be80b65d022c262956cd26fc79d8bb2f7010 -- scanner/redhatbase_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_redhatBase_parseInstalledPackagesLine/invalid_source_package,Test_redhatBase_parseInstalledPackagesLine,Test_redhatBase_parseInstalledPackagesLine/epoch_in_source_package
