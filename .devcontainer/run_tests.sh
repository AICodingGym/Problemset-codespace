#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- detector/detector_test.go 2>/dev/null || true" EXIT
git checkout 78b52d6a7f480bd610b692de9bf0c86f57332f23 -- detector/detector_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_getMaxConfidence/JvnVendorProductMatch,Test_getMaxConfidence/NvdRoughVersionMatch,Test_getMaxConfidence/FortinetExactVersionMatch,Test_getMaxConfidence/NvdExactVersionMatch,Test_getMaxConfidence/NvdVendorProductMatch,Test_getMaxConfidence,TestRemoveInactive,Test_getMaxConfidence/empty
