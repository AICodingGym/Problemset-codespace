#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/elements/Pill-test.tsx test/components/views/elements/__snapshots__/Pill-test.tsx.snap test/components/views/messages/TextualBody-test.tsx test/components/views/messages/__snapshots__/TextualBody-test.tsx.snap test/test-utils/test-utils.ts 2>/dev/null || true" EXIT
git checkout ad26925bb6628260cfe0fcf90ec0a8cba381f4a4 -- test/components/views/elements/Pill-test.tsx test/components/views/elements/__snapshots__/Pill-test.tsx.snap test/components/views/messages/TextualBody-test.tsx test/components/views/messages/__snapshots__/TextualBody-test.tsx.snap test/test-utils/test-utils.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/messages/TextualBody-test.tsx,test/utils/location/parseGeoUri-test.ts,test/components/views/elements/Pill-test.ts,test/editor/serialize-test.ts,test/components/views/rooms/wysiwyg_composer/utils/createMessageContent-test.ts,test/linkify-matrix-test.ts,test/utils/beacon/geolocation-test.ts,test/components/views/messages/TextualBody-test.ts,test/components/views/elements/__snapshots__/Pill-test.tsx.snap,test/components/views/settings/devices/DeviceDetails-test.ts,test/components/views/messages/RoomPredecessorTile-test.ts,test/test-utils/test-utils.ts,test/components/views/settings/tabs/user/SessionManagerTab-test.ts,test/editor/caret-test.ts,test/components/views/elements/Pill-test.tsx,test/utils/MultiInviter-test.ts,test/Terms-test.ts,test/components/views/messages/__snapshots__/TextualBody-test.tsx.snap,test/components/views/rooms/BasicMessageComposer-test.ts,test/utils/exportUtils/HTMLExport-test.ts
