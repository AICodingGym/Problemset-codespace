#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/contacts/import/ContactImportModal.test.tsx packages/shared/test/contacts/property.spec.ts 2>/dev/null || true" EXIT
git checkout f161c10cf7d31abf82e8d64d7a99c9fac5acfa18 -- packages/components/containers/contacts/import/ContactImportModal.test.tsx packages/shared/test/contacts/property.spec.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/contacts/import/ContactImportModal.test.tsx,containers/contacts/import/ContactImportModal.test.ts,packages/shared/test/contacts/property.spec.ts
