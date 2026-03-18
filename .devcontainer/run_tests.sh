#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/inventory/controller_test.go 2>/dev/null || true" EXIT
git checkout cb712e3f0b06dadc679f895daef8072cae400c26 -- lib/inventory/controller_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestControllerBasics,TestStoreAccess
