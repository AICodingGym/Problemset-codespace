#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/client/misc/credentials/NativeCredentialsEncryptionTest.ts 2>/dev/null || true" EXIT
git checkout de49d486feef842101506adf040a0f00ded59519 -- test/client/misc/credentials/NativeCredentialsEncryptionTest.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/client/misc/credentials/NativeCredentialsEncryptionTest.ts,test/api/Suite.ts
