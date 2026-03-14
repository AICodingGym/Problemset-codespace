#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/calendar/subscribeCalendarModal/SubscribeCalendarModal.test.tsx 2>/dev/null || true" EXIT
git checkout d494a66038112b239a381f49b3914caf8d2ef3b4 -- packages/components/containers/calendar/subscribeCalendarModal/SubscribeCalendarModal.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) containers/calendar/subscribeCalendarModal/SubscribeCalendarModal.test.ts,packages/components/containers/calendar/subscribeCalendarModal/SubscribeCalendarModal.test.tsx
