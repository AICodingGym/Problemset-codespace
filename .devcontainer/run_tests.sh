#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/country/CountrySelect.helpers.test.ts packages/components/containers/calendar/holidaysCalendarModal/tests/HolidaysCalendarModal.test.tsx packages/components/containers/calendar/settings/CalendarsSettingsSection.test.tsx packages/shared/test/calendar/holidaysCalendar/holidaysCalendar.spec.ts 2>/dev/null || true" EXIT
git checkout 369fd37de29c14c690cb3b1c09a949189734026f -- packages/components/components/country/CountrySelect.helpers.test.ts packages/components/containers/calendar/holidaysCalendarModal/tests/HolidaysCalendarModal.test.tsx packages/components/containers/calendar/settings/CalendarsSettingsSection.test.tsx packages/shared/test/calendar/holidaysCalendar/holidaysCalendar.spec.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/country/CountrySelect.helpers.test.ts,packages/components/containers/calendar/holidaysCalendarModal/tests/HolidaysCalendarModal.test.tsx,components/country/CountrySelect.helpers.test.ts,packages/shared/test/calendar/holidaysCalendar/holidaysCalendar.spec.ts,containers/calendar/holidaysCalendarModal/tests/HolidaysCalendarModal.test.ts,containers/calendar/settings/CalendarsSettingsSection.test.ts,packages/components/containers/calendar/settings/CalendarsSettingsSection.test.tsx
