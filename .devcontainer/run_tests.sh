#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/test-utils/test-utils.ts test/toasts/UnverifiedSessionToast-test.tsx test/toasts/__snapshots__/UnverifiedSessionToast-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 880428ab94c6ea98d3d18dcaeb17e8767adcb461 -- test/test-utils/test-utils.ts test/toasts/UnverifiedSessionToast-test.tsx test/toasts/__snapshots__/UnverifiedSessionToast-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/toasts/UnverifiedSessionToast-test.tsx,test/components/structures/MessagePanel-test.ts,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.ts,test/hooks/useUserOnboardingTasks-test.ts,test/components/views/spaces/SpaceSettingsVisibilityTab-test.ts,test/components/views/dialogs/polls/PollListItemEnded-test.ts,test/toasts/__snapshots__/UnverifiedSessionToast-test.tsx.snap,test/components/views/elements/PowerSelector-test.ts,test/createRoom-test.ts,test/components/views/settings/tabs/user/KeyboardUserSettingsTab-test.ts,test/test-utils/test-utils.ts,test/toasts/UnverifiedSessionToast-test.ts
