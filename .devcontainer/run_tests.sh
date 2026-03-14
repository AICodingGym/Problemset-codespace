#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/elements.test.ts applications/mail/src/app/helpers/recipients.test.ts 2>/dev/null || true" EXIT
git checkout 2dce79ea4451ad88d6bfe94da22e7f2f988efa60 -- applications/mail/src/app/helpers/elements.test.ts applications/mail/src/app/helpers/recipients.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/helpers/recipients.test.ts,src/app/helpers/elements.test.ts,applications/mail/src/app/helpers/recipients.test.ts,applications/mail/src/app/helpers/elements.test.ts
