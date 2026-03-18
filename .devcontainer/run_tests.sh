#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts test/voice-broadcast/utils/determineVoiceBroadcastLiveness-test.ts 2>/dev/null || true" EXIT
git checkout 6205c70462e0ce2e1e77afb3a70b55d0fdfe1b31 -- test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts test/voice-broadcast/utils/determineVoiceBroadcastLiveness-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/useTopic-test.ts,test/components/views/typography/Caption-test.ts,test/voice-broadcast/utils/determineVoiceBroadcastLiveness-test.ts,test/utils/location/parseGeoUri-test.ts,test/components/views/settings/devices/DeviceDetails-test.ts,test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts,test/stores/room-list/algorithms/Algorithm-test.ts,test/utils/beacon/bounds-test.ts,test/components/views/context_menus/EmbeddedPage-test.ts,test/components/structures/auth/ForgotPassword-test.ts,test/toasts/IncomingCallToast-test.ts,test/components/views/dialogs/ChangelogDialog-test.ts,test/theme-test.ts,test/components/views/settings/tabs/user/SessionManagerTab-test.ts
