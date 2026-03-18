#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/server/auth/method/oidc/server_internal_test.go 2>/dev/null || true" EXIT
git checkout 5af0757e96dec4962a076376d1bedc79de0d4249 -- internal/config/config_test.go internal/server/auth/method/oidc/server_internal_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestCallbackURL
