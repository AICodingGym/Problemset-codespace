#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/expiration.test.ts 2>/dev/null || true" EXIT
git checkout 0ec14e36ceb01ba45602a563e12352af8171ed39 -- applications/mail/src/app/helpers/expiration.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/helpers/expiration.test.ts,applications/mail/src/app/helpers/expiration.test.ts
