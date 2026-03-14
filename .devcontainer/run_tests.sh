#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/contacts/email/ContactEmailSettingsModal.test.tsx packages/shared/test/keys/publicKeys.spec.ts packages/shared/test/mail/encryptionPreferences.spec.ts 2>/dev/null || true" EXIT
git checkout 715dbd4e6999499cd2a576a532d8214f75189116 -- packages/components/containers/contacts/email/ContactEmailSettingsModal.test.tsx packages/shared/test/keys/publicKeys.spec.ts packages/shared/test/mail/encryptionPreferences.spec.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/shared/test/keys/publicKeys.spec.ts,packages/shared/test/mail/encryptionPreferences.spec.ts,packages/components/containers/contacts/email/ContactEmailSettingsModal.test.tsx,containers/contacts/email/ContactEmailSettingsModal.test.ts
