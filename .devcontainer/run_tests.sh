#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/TextForEvent-test.ts 2>/dev/null || true" EXIT
git checkout f3534b42df3dcfe36dc48bddbf14034085af6d30 -- test/TextForEvent-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/stores/BreadcrumbsStore-test.ts,test/components/views/rooms/wysiwyg_composer/utils/autocomplete-test.ts,test/components/views/elements/ReplyChain-test.ts,test/Reply-test.ts,test/utils/notifications-test.ts,test/components/views/elements/PollCreateDialog-test.ts,test/utils/numbers-test.ts,test/components/structures/RoomSearchView-test.ts,test/voice-broadcast/utils/shouldDisplayAsVoiceBroadcastRecordingTile-test.ts,test/components/views/messages/DecryptionFailureBody-test.ts,test/components/views/beacon/RoomCallBanner-test.ts,test/components/views/elements/QRCode-test.ts,test/utils/export-test.ts,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.ts,test/TextForEvent-test.ts,test/components/views/settings/tabs/user/VoiceUserSettingsTab-test.ts,test/components/structures/ThreadView-test.ts,test/components/structures/auth/Login-test.ts
