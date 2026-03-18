#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/touchid/api_test.go 2>/dev/null || true" EXIT
git checkout 65438e6e44b6ce51458d09b7bb028a2797cfb0ea -- lib/auth/touchid/api_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRegisterAndLogin,TestRegister_rollback
