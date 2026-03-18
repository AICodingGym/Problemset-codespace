#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/right_panel/RoomHeaderButtons-test.tsx 2>/dev/null || true" EXIT
git checkout ee13e23b156fbad9369d6a656c827b6444343d4f -- test/components/views/right_panel/RoomHeaderButtons-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/dialogs/InteractiveAuthDialog-test.ts,test/components/views/right_panel/RoomHeaderButtons-test.tsx,test/components/views/rooms/RoomHeader-test.ts,test/components/structures/ThreadView-test.ts,test/components/views/settings/shared/SettingsSubsection-test.ts,test/components/views/right_panel/RoomHeaderButtons-test.ts,test/hooks/useProfileInfo-test.ts,test/ScalarAuthClient-test.ts,test/events/location/getShareableLocationEvent-test.ts,test/voice-broadcast/components/atoms/VoiceBroadcastHeader-test.ts
