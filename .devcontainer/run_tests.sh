#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/test-utils/threads.ts test/unit-tests/components/views/rooms/PinnedMessageBanner-test.tsx test/unit-tests/components/views/rooms/__snapshots__/PinnedMessageBanner-test.tsx.snap 2>/dev/null || true" EXIT
git checkout aeabf3b18896ac1eb7ae9757e66ce886120f8309 -- test/test-utils/threads.ts test/unit-tests/components/views/rooms/PinnedMessageBanner-test.tsx test/unit-tests/components/views/rooms/__snapshots__/PinnedMessageBanner-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/unit-tests/components/views/rooms/RoomHeader/CallGuestLinkButton-test.ts,test/unit-tests/modules/ProxiedModuleApi-test.ts,test/unit-tests/hooks/useUserDirectory-test.ts,test/unit-tests/components/views/emojipicker/EmojiPicker-test.ts,test/unit-tests/voice-broadcast/components/molecules/VoiceBroadcastRecordingPip-test.ts,test/unit-tests/utils/FixedRollingArray-test.ts,test/unit-tests/voice-broadcast/components/VoiceBroadcastBody-test.ts,test/unit-tests/stores/room-list/algorithms/list-ordering/NaturalAlgorithm-test.ts,test/unit-tests/components/views/right_panel/UserInfo-test.ts,test/test-utils/threads.ts,test/unit-tests/components/views/rooms/PinnedMessageBanner-test.ts,test/unit-tests/components/views/settings/tabs/user/PreferencesUserSettingsTab-test.ts,test/unit-tests/components/views/rooms/__snapshots__/PinnedMessageBanner-test.tsx.snap,test/unit-tests/hooks/useLatestResult-test.ts,test/unit-tests/components/views/voip/DialPad-test.ts,test/unit-tests/utils/notifications-test.ts,test/unit-tests/components/views/rooms/wysiwyg_composer/EditWysiwygComposer-test.ts,test/unit-tests/stores/RoomNotificationStateStore-test.ts,test/unit-tests/widgets/ManagedHybrid-test.ts,test/unit-tests/utils/LruCache-test.ts,test/unit-tests/components/views/rooms/PinnedMessageBanner-test.tsx,test/unit-tests/utils/StorageManager-test.ts,test/unit-tests/components/views/settings/SecureBackupPanel-test.ts,test/unit-tests/components/views/settings/tabs/room/RolesRoomSettingsTab-test.ts,test/unit-tests/components/views/dialogs/spotlight/RoomResultContextMenus-test.ts,test/unit-tests/utils/oidc/persistOidcSettings-test.ts
