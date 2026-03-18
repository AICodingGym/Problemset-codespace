#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/messages/MKeyVerificationRequest-test.tsx 2>/dev/null || true" EXIT
git checkout f63160f38459fb552d00fcc60d4064977a9095a6 -- test/components/views/messages/MKeyVerificationRequest-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/theme-test.ts,test/components/views/polls/pollHistory/PollListItemEnded-test.ts,test/widgets/ManagedHybrid-test.ts,test/stores/room-list/MessagePreviewStore-test.ts,test/components/structures/LoggedInView-test.ts,test/components/views/messages/MKeyVerificationRequest-test.ts,test/components/views/messages/MKeyVerificationRequest-test.tsx,test/utils/arrays-test.ts,test/components/structures/auth/ForgotPassword-test.ts,test/voice-broadcast/models/VoiceBroadcastPreRecording-test.ts,test/components/views/beacon/BeaconViewDialog-test.ts,test/components/views/messages/MLocationBody-test.ts,test/components/views/dialogs/InviteDialog-test.ts,test/components/views/rooms/RoomPreviewCard-test.ts,test/utils/device/parseUserAgent-test.ts,test/events/EventTileFactory-test.ts,test/hooks/useDebouncedCallback-test.ts
