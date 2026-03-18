#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/keystore/keystore_test.go 2>/dev/null || true" EXIT
git checkout f432a71a13e698b6e1c4672a2e9e9c1f32d35c12 -- lib/auth/keystore/keystore_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestKeyStore/raw_keystore,TestKeyStore
