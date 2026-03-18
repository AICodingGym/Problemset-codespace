#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/settings/JoinRuleSettings-test.tsx 2>/dev/null || true" EXIT
git checkout 9a31cd0fa849da810b4fac6c6c015145e850b282 -- test/components/views/settings/JoinRuleSettings-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/messages/MessageActionBar-test.ts,test/components/views/settings/EventIndexPanel-test.ts,test/voice-broadcast/stores/VoiceBroadcastPreRecordingStore-test.ts,test/components/views/elements/LabelledCheckbox-test.ts,test/components/views/settings/tabs/user/SessionManagerTab-test.ts,test/components/structures/AutocompleteInput-test.ts,test/components/views/settings/JoinRuleSettings-test.tsx,test/components/views/settings/JoinRuleSettings-test.ts,test/stores/SetupEncryptionStore-test.ts,test/components/views/context_menus/SpaceContextMenu-test.ts
