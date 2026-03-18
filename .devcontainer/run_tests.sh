#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/settings/__snapshots__/DevicesPanel-test.tsx.snap test/components/views/settings/devices/FilteredDeviceList-test.tsx test/components/views/settings/devices/__snapshots__/SelectableDeviceTile-test.tsx.snap test/components/views/settings/tabs/user/SessionManagerTab-test.tsx 2>/dev/null || true" EXIT
git checkout 772df3021201d9c73835a626df8dcb6334ad9a3e -- test/components/views/settings/__snapshots__/DevicesPanel-test.tsx.snap test/components/views/settings/devices/FilteredDeviceList-test.tsx test/components/views/settings/devices/__snapshots__/SelectableDeviceTile-test.tsx.snap test/components/views/settings/tabs/user/SessionManagerTab-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/spaces/SpacePanel-test.ts,test/components/views/settings/DevicesPanel-test.ts,test/hooks/useDebouncedCallback-test.ts,test/components/views/settings/tabs/user/SessionManagerTab-test.tsx,test/components/views/settings/__snapshots__/DevicesPanel-test.tsx.snap,test/components/views/settings/tabs/user/SessionManagerTab-test.ts,test/components/views/rooms/SearchBar-test.ts,test/components/views/settings/devices/SelectableDeviceTile-test.ts,test/utils/tooltipify-test.ts,test/utils/notifications-test.ts,test/components/views/dialogs/SpotlightDialog-test.ts,test/utils/dm/createDmLocalRoom-test.ts,test/modules/ModuleRunner-test.ts,test/components/views/settings/devices/FilteredDeviceList-test.tsx,test/components/views/settings/devices/__snapshots__/SelectableDeviceTile-test.tsx.snap,test/components/views/beacon/BeaconListItem-test.ts
