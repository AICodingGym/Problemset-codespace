#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/settings/Notifications-test.tsx test/components/views/settings/__snapshots__/Notifications-test.tsx.snap test/utils/notifications-test.ts 2>/dev/null || true" EXIT
git checkout e15ef9f3de36df7f318c083e485f44e1de8aad17 -- test/components/views/settings/Notifications-test.tsx test/components/views/settings/__snapshots__/Notifications-test.tsx.snap test/utils/notifications-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/utils/notifications-test.ts,/app/test/utils/notifications-test.ts,/app/test/components/views/settings/Notifications-test.ts,test/components/views/settings/__snapshots__/Notifications-test.tsx.snap,test/components/views/settings/Notifications-test.tsx
