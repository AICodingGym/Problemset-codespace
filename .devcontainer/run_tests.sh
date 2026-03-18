#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.tsx 2>/dev/null || true" EXIT
git checkout 7c63d52500e145d6fff6de41dd717f61ab88d02f -- test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/DevicesPanel-test.ts,test/components/views/settings/discovery/EmailAddresses-test.ts,test/SlidingSyncManager-test.ts,test/events/RelationsHelper-test.ts,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.tsx,test/components/views/settings/devices/DeviceTypeIcon-test.ts,test/components/views/settings/devices/filter-test.ts,test/components/views/settings/shared/SettingsSubsection-test.ts,test/settings/controllers/IncompatibleController-test.ts,test/autocomplete/QueryMatcher-test.ts,test/voice-broadcast/components/molecules/VoiceBroadcastRecordingPip-test.ts,test/editor/diff-test.ts
