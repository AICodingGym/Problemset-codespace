#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/calendar/settings/CalendarMemberAndInvitationList.test.tsx 2>/dev/null || true" EXIT
git checkout bf2e89c0c488ae1a87d503e5b09fe9dd2f2a635f -- packages/components/containers/calendar/settings/CalendarMemberAndInvitationList.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) containers/calendar/settings/CalendarMemberAndInvitationList.test.ts,packages/components/containers/calendar/settings/CalendarMemberAndInvitationList.test.tsx
