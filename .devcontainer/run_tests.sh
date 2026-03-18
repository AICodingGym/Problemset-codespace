#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/config_test.go 2>/dev/null || true" EXIT
git checkout 5ffba3406a7993d97ced4cc13658bee66150fcca -- config/config_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestServeHTTP,TestValidate,TestScheme
