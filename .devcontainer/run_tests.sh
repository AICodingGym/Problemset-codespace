#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/server/authn/method/github/server_test.go 2>/dev/null || true" EXIT
git checkout 40007b9d97e3862bcef8c20ae6c87b22ea0627f0 -- internal/config/config_test.go internal/server/authn/method/github/server_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLoad,TestGithubSimpleOrganizationDecode
