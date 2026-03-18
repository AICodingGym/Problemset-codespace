#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cue/validate_test.go 2>/dev/null || true" EXIT
git checkout c1728053367c753688f114ec26e703c8fdeda125 -- internal/cue/validate_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestValidate_Failure,TestValidate_Success
