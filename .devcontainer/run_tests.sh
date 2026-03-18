#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/utils/AutoDiscoveryUtils-test.tsx 2>/dev/null || true" EXIT
git checkout 41dfec20bfe9b62cddbbbf621bef2e9aa9685157 -- test/utils/AutoDiscoveryUtils-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/rooms/wysiwyg_composer/EditWysiwygComposer-test.ts,test/utils/AutoDiscoveryUtils-test.ts,test/components/views/beacon/BeaconMarker-test.ts,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.ts,test/utils/LruCache-test.ts,test/utils/beacon/bounds-test.ts,test/components/views/dialogs/ChangelogDialog-test.ts,test/utils/AutoDiscoveryUtils-test.tsx,test/components/views/messages/MBeaconBody-test.ts,test/components/views/rooms/VoiceRecordComposerTile-test.ts,test/components/views/rooms/BasicMessageComposer-test.ts
