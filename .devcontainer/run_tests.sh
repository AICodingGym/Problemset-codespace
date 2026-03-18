#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/rooms/__snapshots__/ExtraTile-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 8f3c8b35153d2227af45f32e46bd1e15bd60b71f -- test/components/views/rooms/__snapshots__/ExtraTile-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/structures/ThreadPanel-test.ts,test/components/structures/LegacyCallEventGrouper-test.ts,test/utils/SessionLock-test.ts,test/components/views/context_menus/EmbeddedPage-test.ts,test/stores/room-list/algorithms/list-ordering/NaturalAlgorithm-test.ts,test/components/views/dialogs/InviteDialog-test.ts,test/components/views/voip/LegacyCallView/LegacyCallViewButtons-test.ts,test/components/views/rooms/ExtraTile-test.ts,test/components/views/rooms/__snapshots__/ExtraTile-test.tsx.snap,test/components/views/rooms/MessageComposer-test.ts,test/components/views/messages/MBeaconBody-test.ts,test/components/views/right_panel/VerificationPanel-test.ts,test/components/views/elements/ProgressBar-test.ts,test/components/views/dialogs/AccessSecretStorageDialog-test.ts,test/components/views/elements/AccessibleButton-test.ts,test/components/views/dialogs/CreateRoomDialog-test.ts,test/components/structures/MatrixChat-test.ts
