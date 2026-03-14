#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/calendar/invite.test.ts packages/shared/test/calendar/alarms.spec.ts packages/shared/test/calendar/decrypt.spec.ts packages/shared/test/calendar/getFrequencyString.spec.js packages/shared/test/calendar/integration/invite.spec.js packages/shared/test/calendar/recurring.spec.js packages/shared/test/calendar/rrule/rrule.spec.js packages/shared/test/calendar/rrule/rruleEqual.spec.js packages/shared/test/calendar/rrule/rruleSubset.spec.js packages/shared/test/calendar/rrule/rruleUntil.spec.js packages/shared/test/calendar/rrule/rruleWkst.spec.js 2>/dev/null || true" EXIT
git checkout caf10ba9ab2677761c88522d1ba8ad025779c492 -- applications/mail/src/app/helpers/calendar/invite.test.ts packages/shared/test/calendar/alarms.spec.ts packages/shared/test/calendar/decrypt.spec.ts packages/shared/test/calendar/getFrequencyString.spec.js packages/shared/test/calendar/integration/invite.spec.js packages/shared/test/calendar/recurring.spec.js packages/shared/test/calendar/rrule/rrule.spec.js packages/shared/test/calendar/rrule/rruleEqual.spec.js packages/shared/test/calendar/rrule/rruleSubset.spec.js packages/shared/test/calendar/rrule/rruleUntil.spec.js packages/shared/test/calendar/rrule/rruleWkst.spec.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/shared/test/calendar/recurring.spec.js,packages/shared/test/calendar/alarms.spec.ts,src/app/helpers/calendar/invite.test.ts,packages/shared/test/calendar/rrule/rruleEqual.spec.js,packages/shared/test/calendar/decrypt.spec.ts,packages/shared/test/calendar/rrule/rruleWkst.spec.js,packages/shared/test/calendar/rrule/rruleUntil.spec.js,packages/shared/test/calendar/rrule/rrule.spec.js,packages/shared/test/calendar/rrule/rruleSubset.spec.js,packages/shared/test/calendar/integration/invite.spec.js,packages/shared/test/calendar/getFrequencyString.spec.js,applications/mail/src/app/helpers/calendar/invite.test.ts
