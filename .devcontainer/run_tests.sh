#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/message/messageBlockquote.test.ts 2>/dev/null || true" EXIT
git checkout 2f66db85455f4b22a47ffd853738f679b439593c -- applications/mail/src/app/helpers/message/messageBlockquote.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/helpers/message/messageBlockquote.test.ts,src/app/helpers/message/messageBlockquote.test.ts
