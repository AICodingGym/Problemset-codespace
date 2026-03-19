#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/elements.test.ts 2>/dev/null || true" EXIT
git checkout 09fcf0dbdb87fa4f4a27700800ee4a3caed8b413 -- applications/mail/src/app/helpers/elements.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/helpers/elements.test.ts,applications/mail/src/app/helpers/elements.test.ts
