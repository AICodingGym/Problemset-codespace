#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/structures/RoomSearchView-test.tsx test/components/views/rooms/SearchResultTile-test.tsx 2>/dev/null || true" EXIT
git checkout ecfd1736e5dd9808e87911fc264e6c816653e1a9 -- test/components/structures/RoomSearchView-test.tsx test/components/views/rooms/SearchResultTile-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/rooms/SearchResultTile-test.ts,test/utils/sets-test.ts,test/components/structures/RoomSearchView-test.tsx,test/components/structures/RoomSearchView-test.ts,test/utils/direct-messages-test.ts,test/components/views/settings/devices/DeviceExpandDetailsButton-test.ts,test/components/views/context_menus/ThreadListContextMenu-test.ts,test/components/views/rooms/SearchResultTile-test.tsx
