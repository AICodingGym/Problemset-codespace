#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/test-utils/test-utils.ts test/voice-broadcast/components/VoiceBroadcastBody-test.tsx test/voice-broadcast/models/VoiceBroadcastRecording-test.ts test/voice-broadcast/stores/VoiceBroadcastRecordingsStore-test.ts test/voice-broadcast/utils/startNewVoiceBroadcastRecording-test.ts 2>/dev/null || true" EXIT
git checkout fe14847bb9bb07cab1b9c6c54335ff22ca5e516a -- test/test-utils/test-utils.ts test/voice-broadcast/components/VoiceBroadcastBody-test.tsx test/voice-broadcast/models/VoiceBroadcastRecording-test.ts test/voice-broadcast/stores/VoiceBroadcastRecordingsStore-test.ts test/voice-broadcast/utils/startNewVoiceBroadcastRecording-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/dialogs/SpotlightDialog-test.ts,test/voice-broadcast/components/VoiceBroadcastBody-test.tsx,test/components/views/settings/devices/SelectableDeviceTile-test.ts,test/components/structures/TabbedView-test.ts,test/voice-broadcast/utils/startNewVoiceBroadcastRecording-test.ts,test/notifications/ContentRules-test.ts,test/components/views/dialogs/ExportDialog-test.ts,test/test-utils/test-utils.ts,test/voice-broadcast/components/VoiceBroadcastBody-test.ts,test/createRoom-test.ts,test/voice-broadcast/models/VoiceBroadcastRecording-test.ts,test/voice-broadcast/stores/VoiceBroadcastRecordingsStore-test.ts,test/hooks/useDebouncedCallback-test.ts,test/utils/validate/numberInRange-test.ts,test/modules/ModuleComponents-test.ts,test/components/views/settings/Notifications-test.ts
