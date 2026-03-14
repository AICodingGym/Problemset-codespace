#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/components/composer/tests/Composer.expiration.test.tsx applications/mail/src/app/components/composer/tests/Composer.hotkeys.test.tsx applications/mail/src/app/components/composer/tests/Composer.outsideEncryption.test.tsx 2>/dev/null || true" EXIT
git checkout 6e1873b06df6529a469599aa1d69d3b18f7d9d37 -- applications/mail/src/app/components/composer/tests/Composer.expiration.test.tsx applications/mail/src/app/components/composer/tests/Composer.hotkeys.test.tsx applications/mail/src/app/components/composer/tests/Composer.outsideEncryption.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/components/composer/tests/Composer.hotkeys.test.ts,applications/mail/src/app/components/composer/tests/Composer.outsideEncryption.test.tsx,src/app/components/composer/tests/Composer.outsideEncryption.test.ts,applications/mail/src/app/components/composer/tests/Composer.expiration.test.tsx,src/app/components/composer/tests/Composer.expiration.test.ts,applications/mail/src/app/components/composer/tests/Composer.hotkeys.test.tsx
