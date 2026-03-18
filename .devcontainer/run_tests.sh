#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap test/components/views/settings/shared/SettingsSubsectionHeading-test.tsx test/components/views/settings/shared/__snapshots__/SettingsSubsectionHeading-test.tsx.snap test/components/views/settings/tabs/user/SessionManagerTab-test.tsx test/components/views/settings/tabs/user/__snapshots__/SessionManagerTab-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 776ffa47641c7ec6d142ab4a47691c30ebf83c2e -- test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap test/components/views/settings/shared/SettingsSubsectionHeading-test.tsx test/components/views/settings/shared/__snapshots__/SettingsSubsectionHeading-test.tsx.snap test/components/views/settings/tabs/user/SessionManagerTab-test.tsx test/components/views/settings/tabs/user/__snapshots__/SessionManagerTab-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/settings/tabs/user/SessionManagerTab-test.tsx,test/components/views/settings/shared/__snapshots__/SettingsSubsectionHeading-test.tsx.snap,/app/test/components/views/settings/devices/CurrentDeviceSection-test.ts,test/components/views/settings/devices/__snapshots__/CurrentDeviceSection-test.tsx.snap,test/components/views/settings/tabs/user/__snapshots__/SessionManagerTab-test.tsx.snap,/app/test/components/views/settings/tabs/user/SessionManagerTab-test.ts,test/components/views/settings/shared/SettingsSubsectionHeading-test.tsx
