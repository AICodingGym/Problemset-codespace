#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/moveToFolder.test.ts 2>/dev/null || true" EXIT
git checkout dfe5604193d63bfcb91ce60d62db2f805c43bf11 -- applications/mail/src/app/helpers/moveToFolder.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/helpers/moveToFolder.test.ts,src/app/helpers/moveToFolder.test.ts
