#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/components/conversation/ConversationView.test.tsx applications/mail/src/app/hooks/useShouldMoveOut.test.ts 2>/dev/null || true" EXIT
git checkout 01ea5214d11e0df8b7170d91bafd34f23cb0f2b1 -- applications/mail/src/app/components/conversation/ConversationView.test.tsx applications/mail/src/app/hooks/useShouldMoveOut.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/hooks/useShouldMoveOut.test.ts,applications/mail/src/app/hooks/useShouldMoveOut.test.ts,applications/mail/src/app/components/conversation/ConversationView.test.tsx
