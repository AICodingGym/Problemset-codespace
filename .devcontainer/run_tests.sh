#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/os_test.go scanner/windows_test.go 2>/dev/null || true" EXIT
git checkout 436341a4a522dc83eb8bddd1164b764c8dd6bc45 -- config/os_test.go scanner/windows_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEOL_IsStandardSupportEnded/Fedora_38_supported,TestEOL_IsStandardSupportEnded/Fedora_37_eol_since_2023-12-6,TestEOL_IsStandardSupportEnded,Test_windows_detectKBsFromKernelVersion/10.0.19045.2130,Test_windows_detectKBsFromKernelVersion/10.0.20348.9999,Test_windows_detectKBsFromKernelVersion/10.0.19045.2129,Test_windows_detectKBsFromKernelVersion,Test_windows_detectKBsFromKernelVersion/10.0.20348.1547,TestEOL_IsStandardSupportEnded/Fedora_40_supported,Test_windows_detectKBsFromKernelVersion/10.0.22621.1105
