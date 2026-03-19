#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/os_test.go 2>/dev/null || true" EXIT
git checkout cc63a0eccfdd318e67c0a6edeffc7bf09b6025c0 -- config/os_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEOL_IsStandardSupportEnded/Ubuntu_20.04_ext_supported,TestEOL_IsStandardSupportEnded,TestEOL_IsStandardSupportEnded/Ubuntu_22.04_supported
