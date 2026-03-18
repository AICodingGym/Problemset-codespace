#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/utils/MessageDiffUtils-test.tsx test/utils/__snapshots__/MessageDiffUtils-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 53a9b6447bd7e6110ee4a63e2ec0322c250f08d1 -- test/utils/MessageDiffUtils-test.tsx test/utils/__snapshots__/MessageDiffUtils-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/structures/MessagePanel-test.ts,test/stores/MemberListStore-test.ts,test/components/views/messages/TextualBody-test.ts,test/components/structures/auth/Login-test.ts,test/utils/__snapshots__/MessageDiffUtils-test.tsx.snap,test/KeyBindingsManager-test.ts,test/voice-broadcast/utils/pauseNonLiveBroadcastFromOtherRoom-test.ts,test/components/views/settings/AddPrivilegedUsers-test.ts,test/components/views/dialogs/DevtoolsDialog-test.ts,test/utils/maps-test.ts,test/settings/watchers/ThemeWatcher-test.ts,test/components/views/messages/MessageEvent-test.ts,test/utils/beacon/geolocation-test.ts,test/components/views/location/Map-test.ts,test/SlashCommands-test.ts,test/components/views/elements/ReplyChain-test.ts,test/components/views/dialogs/InviteDialog-test.ts,test/components/views/beacon/BeaconViewDialog-test.ts,test/events/RelationsHelper-test.ts,test/events/location/getShareableLocationEvent-test.ts,test/components/views/elements/EventListSummary-test.ts,test/components/views/settings/devices/LoginWithQRFlow-test.ts,test/components/views/spaces/SpaceTreeLevel-test.ts,test/editor/history-test.ts,test/components/views/avatars/BaseAvatar-test.ts,test/linkify-matrix-test.ts,test/utils/MessageDiffUtils-test.tsx,test/PosthogAnalytics-test.ts,test/utils/device/clientInformation-test.ts,test/components/views/rooms/RoomPreviewBar-test.ts,test/Markdown-test.ts,test/components/views/right_panel/PinnedMessagesCard-test.ts,test/components/views/settings/devices/LoginWithQR-test.ts,test/utils/MessageDiffUtils-test.ts,test/components/views/settings/discovery/EmailAddresses-test.ts,test/modules/ProxiedModuleApi-test.ts
