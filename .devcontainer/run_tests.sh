#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/MatrixClientPeg-test.ts 2>/dev/null || true" EXIT
git checkout 404c412bcb694f04ba0c4d5479541203d701bca0 -- test/MatrixClientPeg-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/tabs/user/SecurityUserSettingsTab-test.ts,test/utils/pillify-test.ts,test/utils/notifications-test.ts,test/components/views/settings/AddPrivilegedUsers-test.ts,test/SlidingSyncManager-test.ts,test/utils/device/parseUserAgent-test.ts,test/MatrixClientPeg-test.ts
