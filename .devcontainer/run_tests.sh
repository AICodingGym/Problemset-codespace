#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_uploads/worker/encryption.test.ts 2>/dev/null || true" EXIT
git checkout 5d2576632037d655c3b6a28e98cd157f7e9a5ce1 -- applications/drive/src/app/store/_uploads/worker/encryption.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/store/_uploads/worker/encryption.test.ts,applications/drive/src/app/store/_uploads/worker/encryption.test.ts
