#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/containers/mailbox/tests/Mailbox.retries.test.tsx 2>/dev/null || true" EXIT
git checkout e65cc5f33719e02e1c378146fb981d27bc24bdf4 -- applications/mail/src/app/containers/mailbox/tests/Mailbox.retries.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/containers/mailbox/tests/Mailbox.retries.test.ts,applications/mail/src/app/containers/mailbox/tests/Mailbox.retries.test.tsx
