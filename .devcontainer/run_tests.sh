#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/windows_test.go 2>/dev/null || true" EXIT
git checkout 457a3a9627fb9a0800d0aecf1d4713fb634a9011 -- scanner/windows_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_windows_detectKBsFromKernelVersion,Test_windows_detectKBsFromKernelVersion/10.0.20348.1547,Test_windows_detectKBsFromKernelVersion/10.0.22621.1105,Test_windows_detectKBsFromKernelVersion/10.0.19045.2129,Test_windows_detectKBsFromKernelVersion/10.0.20348.9999,Test_windows_detectKBsFromKernelVersion/10.0.19045.2130
