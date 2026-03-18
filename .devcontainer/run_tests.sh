#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/test-utils/utilities.ts test/unit-tests/components/views/messages/MPollBody-test.tsx test/unit-tests/components/views/settings/JoinRuleSettings-test.tsx test/unit-tests/components/views/settings/SecureBackupPanel-test.tsx test/unit-tests/utils/pillify-test.tsx test/unit-tests/utils/tooltipify-test.tsx 2>/dev/null || true" EXIT
git checkout d06cf09bf0b3d4a0fbe6bd32e4115caea2083168 -- test/test-utils/utilities.ts test/unit-tests/components/views/messages/MPollBody-test.tsx test/unit-tests/components/views/settings/JoinRuleSettings-test.tsx test/unit-tests/components/views/settings/SecureBackupPanel-test.tsx test/unit-tests/utils/pillify-test.tsx test/unit-tests/utils/tooltipify-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/unit-tests/vector/platform/WebPlatform-test.ts,test/unit-tests/hooks/useUserDirectory-test.ts,test/unit-tests/utils/UrlUtils-test.ts,test/test-utils/utilities.ts,test/unit-tests/components/views/settings/SecureBackupPanel-test.tsx,test/unit-tests/utils/tooltipify-test.ts,test/unit-tests/utils/pillify-test.tsx,test/unit-tests/components/views/messages/MPollBody-test.tsx,test/unit-tests/components/views/location/LocationPicker-test.ts,test/unit-tests/components/views/polls/pollHistory/PollHistory-test.ts,test/unit-tests/settings/handlers/RoomDeviceSettingsHandler-test.ts,test/CreateCrossSigning-test.ts,test/unit-tests/editor/caret-test.ts,test/unit-tests/components/views/settings/JoinRuleSettings-test.tsx,test/unit-tests/components/views/context_menus/RoomGeneralContextMenu-test.ts,test/unit-tests/utils/tooltipify-test.tsx,test/unit-tests/voice-broadcast/utils/hasRoomLiveVoiceBroadcast-test.ts,test/unit-tests/components/views/toasts/VerificationRequestToast-test.ts,test/unit-tests/utils/pillify-test.ts
