#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/linux/dmi_sysfs_test.go lib/linux/os_release_test.go 2>/dev/null || true" EXIT
git checkout eefac60a350930e5f295f94a2d55b94c1988c04e -- lib/linux/dmi_sysfs_test.go lib/linux/os_release_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDMI,TestParseOSReleaseFromReader/Ubuntu_22.04,TestDMI/success,TestParseOSReleaseFromReader/invalid_lines_ignored,TestParseOSReleaseFromReader,TestDMI/realistic
