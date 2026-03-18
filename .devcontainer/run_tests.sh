#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/rooms/RoomHeader-test.tsx test/components/views/rooms/__snapshots__/RoomHeader-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 33299af5c9b7a7ec5a9c31d578d4ec5b18088fb7 -- test/components/views/rooms/RoomHeader-test.tsx test/components/views/rooms/__snapshots__/RoomHeader-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/Notifications-test.ts,test/stores/widgets/WidgetPermissionStore-test.ts,test/components/views/rooms/__snapshots__/RoomHeader-test.tsx.snap,test/components/views/polls/pollHistory/PollListItemEnded-test.ts,test/components/views/rooms/RoomHeader-test.tsx,test/hooks/useProfileInfo-test.ts,test/stores/room-list/algorithms/RecentAlgorithm-test.ts,test/components/views/elements/AppTile-test.ts,test/i18n-test/languageHandler-test.ts,test/components/views/settings/devices/deleteDevices-test.ts,test/utils/DateUtils-test.ts,test/components/views/dialogs/CreateRoomDialog-test.ts,test/editor/history-test.ts,test/components/views/rooms/wysiwyg_composer/components/WysiwygComposer-test.ts,test/voice-broadcast/components/molecules/VoiceBroadcastPlaybackBody-test.ts,test/components/views/rooms/RoomHeader-test.ts,test/components/structures/RightPanel-test.ts,test/stores/RoomViewStore-test.ts,test/voice-broadcast/stores/VoiceBroadcastRecordingsStore-test.ts,test/components/structures/auth/ForgotPassword-test.ts
