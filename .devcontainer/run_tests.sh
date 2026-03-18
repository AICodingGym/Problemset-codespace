#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/init_test.go 2>/dev/null || true" EXIT
git checkout b5d8169fc0a5e43fee2616c905c6d32164654dc6 -- lib/auth/init_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMigrateOSS/User,TestMigrateOSS,TestMigrateOSS/EmptyCluster,TestMigrateOSS/TrustedCluster
