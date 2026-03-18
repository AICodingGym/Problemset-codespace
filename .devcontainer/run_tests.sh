#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/LegacyCallHandler-test.ts 2>/dev/null || true" EXIT
git checkout ca58617cee8aa91c93553449bfdf9b3465a5119b -- test/LegacyCallHandler-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/rooms/NotificationBadge/NotificationBadge-test.ts,test/LegacyCallHandler-test.ts,test/components/views/elements/LabelledCheckbox-test.ts,test/modules/ModuleRunner-test.ts,test/utils/beacon/geolocation-test.ts,test/components/views/context_menus/ContextMenu-test.ts,test/components/views/settings/tabs/room/VoipRoomSettingsTab-test.ts,test/components/views/settings/devices/SecurityRecommendations-test.ts,test/components/views/audio_messages/RecordingPlayback-test.ts,test/components/structures/auth/ForgotPassword-test.ts,test/components/views/spaces/SpacePanel-test.ts,test/components/views/settings/devices/filter-test.ts,test/components/views/rooms/wysiwyg_composer/utils/createMessageContent-test.ts,test/audio/Playback-test.ts
