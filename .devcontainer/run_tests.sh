#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/voice-broadcast/components/molecules/VoiceBroadcastPlaybackBody-test.tsx test/voice-broadcast/components/molecules/__snapshots__/VoiceBroadcastPlaybackBody-test.tsx.snap test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts test/voice-broadcast/utils/VoiceBroadcastChunkEvents-test.ts 2>/dev/null || true" EXIT
git checkout 66d0b318bc6fee0d17b54c1781d6ab5d5d323135 -- test/voice-broadcast/components/molecules/VoiceBroadcastPlaybackBody-test.tsx test/voice-broadcast/components/molecules/__snapshots__/VoiceBroadcastPlaybackBody-test.tsx.snap test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts test/voice-broadcast/utils/VoiceBroadcastChunkEvents-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/voice-broadcast/models/VoiceBroadcastPlayback-test.ts,test/components/views/elements/Linkify-test.ts,test/components/views/voip/CallView-test.ts,test/voice-broadcast/utils/hasRoomLiveVoiceBroadcast-test.ts,test/voice-broadcast/components/molecules/__snapshots__/VoiceBroadcastPlaybackBody-test.tsx.snap,test/voice-broadcast/components/molecules/VoiceBroadcastPlaybackBody-test.tsx,test/stores/widgets/StopGapWidget-test.ts,test/components/views/settings/devices/DeviceExpandDetailsButton-test.ts,test/voice-broadcast/components/molecules/VoiceBroadcastPlaybackBody-test.ts,test/components/views/settings/UiFeatureSettingWrapper-test.ts,test/components/views/right_panel/PinnedMessagesCard-test.ts,test/voice-broadcast/utils/VoiceBroadcastChunkEvents-test.ts
