#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/containers/onboardingChecklist/hooks/useCanCheckItem.test.ts 2>/dev/null || true" EXIT
git checkout b530a3db50cb33e5064464addbcbef1465856ce6 -- applications/mail/src/app/containers/onboardingChecklist/hooks/useCanCheckItem.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/containers/onboardingChecklist/hooks/useCanCheckItem.test.ts,src/app/containers/onboardingChecklist/hooks/useCanCheckItem.test.ts
