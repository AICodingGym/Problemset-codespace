#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/components/header/MailHeader.test.tsx applications/mail/src/app/components/sidebar/MailSidebar.test.tsx 2>/dev/null || true" EXIT
git checkout f080ffc38e2ad7bddf2e93e5193e82c20c7a11e7 -- applications/mail/src/app/components/header/MailHeader.test.tsx applications/mail/src/app/components/sidebar/MailSidebar.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/components/sidebar/MailSidebar.test.ts,applications/mail/src/app/components/sidebar/MailSidebar.test.tsx,applications/mail/src/app/components/header/MailHeader.test.tsx
