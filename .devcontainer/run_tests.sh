#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/components/message/extras/ExtraEvents.test.tsx packages/components/containers/calendar/settings/PersonalCalendarsSection.test.tsx packages/shared/test/calendar/subscribe/helpers.spec.ts 2>/dev/null || true" EXIT
git checkout 8142704f447df6e108d53cab25451c8a94976b92 -- applications/mail/src/app/components/message/extras/ExtraEvents.test.tsx packages/components/containers/calendar/settings/PersonalCalendarsSection.test.tsx packages/shared/test/calendar/subscribe/helpers.spec.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/components/message/extras/ExtraEvents.test.ts,packages/shared/test/calendar/subscribe/helpers.spec.ts,containers/calendar/settings/PersonalCalendarsSection.test.ts,packages/components/containers/calendar/settings/PersonalCalendarsSection.test.tsx,applications/mail/src/app/components/message/extras/ExtraEvents.test.tsx
