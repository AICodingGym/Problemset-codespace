#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/settings/devices/DeviceDetails-test.tsx test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap test/components/views/settings/devices/__snapshots__/DeviceDetails-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 9bf77963ee5e036d54b2a3ca202fbf6378464a5e -- test/components/views/settings/devices/DeviceDetails-test.tsx test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap test/components/views/settings/devices/__snapshots__/DeviceDetails-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/dialogs/ExportDialog-test.ts,test/components/views/settings/devices/CurrentDeviceSection-test.ts,test/components/views/settings/SettingsFieldset-test.ts,test/ContentMessages-test.ts,test/components/views/settings/devices/DeviceDetails-test.ts,test/components/views/settings/devices/__snapshots__/DeviceDetails-test.tsx.snap,test/components/views/settings/devices/DeviceDetails-test.tsx,test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap,test/editor/serialize-test.ts,test/stores/RoomViewStore-test.ts,test/components/views/settings/DevicesPanel-test.ts,test/events/location/getShareableLocationEvent-test.ts,test/utils/beacon/bounds-test.ts,test/components/views/dialogs/SpotlightDialog-test.ts,test/components/views/elements/InteractiveTooltip-test.ts,test/utils/iterables-test.ts
