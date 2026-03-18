#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cue/validate_test.go 2>/dev/null || true" EXIT
git checkout f36bd61fb1cee4669de1f00e59da462bfeae8765 -- internal/cue/validate_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestValidate_Success,TestValidate_Failure
