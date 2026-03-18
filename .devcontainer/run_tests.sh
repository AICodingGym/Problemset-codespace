#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/elements/Pill-test.tsx test/components/views/elements/__snapshots__/Pill-test.tsx.snap test/contexts/SdkContext-test.ts test/stores/UserProfilesStore-test.ts test/utils/LruCache-test.ts 2>/dev/null || true" EXIT
git checkout aec454dd6feeb93000380523cbb0b3681c0275fd -- test/components/views/elements/Pill-test.tsx test/components/views/elements/__snapshots__/Pill-test.tsx.snap test/contexts/SdkContext-test.ts test/stores/UserProfilesStore-test.ts test/utils/LruCache-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/elements/__snapshots__/Pill-test.tsx.snap,test/components/views/dialogs/InviteDialog-test.ts,test/i18n-test/languageHandler-test.ts,test/components/structures/AutocompleteInput-test.ts,test/voice-broadcast/audio/VoiceBroadcastRecorder-test.ts,test/stores/UserProfilesStore-test.ts,test/components/views/beacon/DialogSidebar-test.ts,test/components/views/elements/Pill-test.tsx,test/components/views/messages/MImageBody-test.ts,test/utils/LruCache-test.ts,test/components/views/dialogs/ExportDialog-test.ts,test/contexts/SdkContext-test.ts,test/components/views/elements/AccessibleButton-test.ts,test/components/views/rooms/wysiwyg_composer/components/WysiwygComposer-test.ts
