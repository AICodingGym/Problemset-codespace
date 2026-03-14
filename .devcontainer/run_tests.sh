#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/message/messageDraft.test.ts applications/mail/src/app/helpers/message/messageSignature.test.ts applications/mail/src/app/helpers/textToHtml.test.ts 2>/dev/null || true" EXIT
git checkout 4817fe14e1356789c90165c2a53f6a043c2c5f83 -- applications/mail/src/app/helpers/message/messageDraft.test.ts applications/mail/src/app/helpers/message/messageSignature.test.ts applications/mail/src/app/helpers/textToHtml.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/helpers/textToHtml.test.ts,src/app/helpers/message/messageSignature.test.ts,applications/mail/src/app/helpers/message/messageSignature.test.ts,applications/mail/src/app/helpers/message/messageDraft.test.ts,src/app/helpers/message/messageDraft.test.ts
