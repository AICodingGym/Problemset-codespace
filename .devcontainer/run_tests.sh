#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/auth/RegistrationToken-test.tsx 2>/dev/null || true" EXIT
git checkout 6961c256035bed0b7640a6e5907652c806968478 -- test/components/views/auth/RegistrationToken-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/tabs/user/SessionManagerTab-test.ts,test/components/views/spaces/QuickThemeSwitcher-test.ts,test/components/views/rooms/wysiwyg_composer/components/WysiwygComposer-test.ts,test/voice-broadcast/utils/startNewVoiceBroadcastRecording-test.ts,test/components/views/settings/devices/filter-test.ts,test/components/views/auth/RegistrationToken-test.tsx,test/components/views/settings/DevicesPanel-test.ts,test/utils/device/parseUserAgent-test.ts,test/components/views/settings/devices/SecurityRecommendations-test.ts,test/stores/room-list/filters/VisibilityProvider-test.ts,test/components/views/auth/RegistrationToken-test.ts,test/utils/FixedRollingArray-test.ts,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.ts,test/components/views/elements/ExternalLink-test.ts,test/components/structures/ThreadPanel-test.ts,test/components/views/elements/Linkify-test.ts
