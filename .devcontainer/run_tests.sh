#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/dialogs/spotlight/RoomResultContextMenus-test.tsx test/components/views/rooms/RoomHeader-test.tsx test/components/views/rooms/RoomTile-test.tsx 2>/dev/null || true" EXIT
git checkout 53b42e321777a598aaf2bb3eab22d710569f83a8 -- test/components/views/dialogs/spotlight/RoomResultContextMenus-test.tsx test/components/views/rooms/RoomHeader-test.tsx test/components/views/rooms/RoomTile-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/tabs/room/SecurityRoomSettingsTab-test.ts,test/components/views/dialogs/spotlight/RoomResultContextMenus-test.tsx,test/utils/ShieldUtils-test.ts,test/components/structures/LoggedInView-test.ts,test/stores/room-list/MessagePreviewStore-test.ts,test/components/views/rooms/RoomHeader-test.ts,test/components/views/settings/tabs/room/VoipRoomSettingsTab-test.ts,test/components/structures/ThreadView-test.ts,test/components/views/dialogs/spotlight/RoomResultContextMenus-test.ts,test/components/views/rooms/RoomHeader-test.tsx,test/components/views/rooms/wysiwyg_composer/SendWysiwygComposer-test.ts,test/components/views/rooms/RoomTile-test.ts,test/components/structures/auth/Registration-test.ts,test/components/views/elements/crypto/VerificationQRCode-test.ts,test/components/views/rooms/RoomTile-test.tsx,test/utils/DateUtils-test.ts,test/components/views/messages/MessageActionBar-test.ts,test/utils/tooltipify-test.ts,test/utils/exportUtils/HTMLExport-test.ts
