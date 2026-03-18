#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/structures/RoomView-test.tsx test/stores/RoomViewStore-test.ts 2>/dev/null || true" EXIT
git checkout 494d9de6f0a94ffb491e74744d2735bce02dc0ab -- test/components/structures/RoomView-test.tsx test/stores/RoomViewStore-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/devices/filter-test.ts,test/components/structures/LoggedInView-test.ts,test/languageHandler-test.ts,test/components/views/settings/devices/SecurityRecommendations-test.ts,test/utils/EventUtils-test.ts,test/events/RelationsHelper-test.ts,test/utils/exportUtils/exportCSS-test.ts,test/components/views/settings/EventIndexPanel-test.ts,test/stores/RoomViewStore-test.ts,test/components/structures/RoomView-test.tsx,test/SlashCommands-test.ts,test/components/views/messages/MStickerBody-test.ts,test/components/views/messages/DateSeparator-test.ts,test/components/views/beacon/LeftPanelLiveShareWarning-test.ts,test/utils/room/canInviteTo-test.ts,test/settings/handlers/RoomDeviceSettingsHandler-test.ts,test/components/views/rooms/RoomPreviewBar-test.ts,test/components/views/settings/CrossSigningPanel-test.ts,test/components/views/beacon/OwnBeaconStatus-test.ts,test/components/views/elements/Pill-test.ts,test/components/views/audio_messages/RecordingPlayback-test.ts,test/components/views/messages/EncryptionEvent-test.ts,test/components/views/elements/ExternalLink-test.ts
