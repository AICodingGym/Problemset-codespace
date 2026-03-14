#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/components/message/tests/Message.images.test.tsx applications/mail/src/app/helpers/message/messageImages.test.ts applications/mail/src/app/helpers/test/helper.ts applications/mail/src/app/helpers/test/render.tsx 2>/dev/null || true" EXIT
git checkout 1917e37f5d9941a3459ce4b0177e201e2d94a622 -- applications/mail/src/app/components/message/tests/Message.images.test.tsx applications/mail/src/app/helpers/message/messageImages.test.ts applications/mail/src/app/helpers/test/helper.ts applications/mail/src/app/helpers/test/render.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/helpers/test/render.tsx,src/app/helpers/message/messageImages.test.ts,applications/mail/src/app/helpers/test/helper.ts,src/app/components/message/tests/Message.images.test.ts,applications/mail/src/app/helpers/message/messageImages.test.ts,applications/mail/src/app/components/message/tests/Message.images.test.tsx
