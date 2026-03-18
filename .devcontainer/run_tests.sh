#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/tests/api/worker/crypto/CryptoFacadeTest.ts test/tests/api/worker/rest/EntityRestCacheTest.ts test/tests/api/worker/search/MailIndexerTest.ts 2>/dev/null || true" EXIT
git checkout f373ac3808deefce8183dad8d16729839cc330c1 -- test/tests/api/worker/crypto/CryptoFacadeTest.ts test/tests/api/worker/rest/EntityRestCacheTest.ts test/tests/api/worker/search/MailIndexerTest.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/tests/api/worker/rest/EntityRestCacheTest.ts,test/tests/Suite.js,test/tests/api/worker/search/MailIndexerTest.ts,test/tests/api/worker/crypto/CryptoFacadeTest.ts
