#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/util/chunk.test.ts 2>/dev/null || true" EXIT
git checkout 815695401137dac2975400fc610149a16db8214b -- packages/util/chunk.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/util/chunk.test.ts,packages/key-transparency/test/vrf.spec.js
