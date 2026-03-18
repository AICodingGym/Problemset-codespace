#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/right_panel/RoomSummaryCard-test.tsx test/components/views/right_panel/__snapshots__/RoomSummaryCard-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 923ad4323b2006b2b180544429455ffe7d4a6cc3 -- test/components/views/right_panel/RoomSummaryCard-test.tsx test/components/views/right_panel/__snapshots__/RoomSummaryCard-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/right_panel/RoomSummaryCard-test.tsx,test/components/views/elements/Linkify-test.ts,test/components/views/voip/CallView-test.ts,test/components/views/right_panel/RoomHeaderButtons-test.ts,test/components/views/elements/ExternalLink-test.ts,test/components/views/right_panel/RoomSummaryCard-test.ts,test/components/views/right_panel/__snapshots__/RoomSummaryCard-test.tsx.snap,test/components/structures/ThreadPanel-test.ts,test/voice-broadcast/utils/textForVoiceBroadcastStoppedEventWithoutLink-test.ts,test/settings/watchers/ThemeWatcher-test.ts
