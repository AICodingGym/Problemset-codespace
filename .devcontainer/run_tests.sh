#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/dialogs/security/ExportE2eKeysDialog-test.tsx test/components/views/dialogs/security/__snapshots__/ExportE2eKeysDialog-test.tsx.snap test/test-utils/test-utils.ts 2>/dev/null || true" EXIT
git checkout d405160080bbe804f7e9294067d004a7d4dad9d6 -- test/components/views/dialogs/security/ExportE2eKeysDialog-test.tsx test/components/views/dialogs/security/__snapshots__/ExportE2eKeysDialog-test.tsx.snap test/test-utils/test-utils.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/dialogs/security/ExportE2eKeysDialog-test.tsx,test/components/views/dialogs/security/ExportE2eKeysDialog-test.ts,test/test-utils/test-utils.ts,test/components/views/dialogs/security/__snapshots__/ExportE2eKeysDialog-test.tsx.snap
