#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/contacts/group/ContactGroupDetailsModal.test.tsx 2>/dev/null || true" EXIT
git checkout 32ff10999a06455cb2147f6873d627456924ae13 -- packages/components/containers/contacts/group/ContactGroupDetailsModal.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/contacts/group/ContactGroupDetailsModal.test.tsx,containers/contacts/group/ContactGroupDetailsModal.test.ts
