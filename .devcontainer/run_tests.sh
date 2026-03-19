#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/v2/input/TotpInput.test.tsx 2>/dev/null || true" EXIT
git checkout 08bb09914d0d37b0cd6376d4cab5b77728a43e7b -- packages/components/components/v2/input/TotpInput.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/v2/input/TotpInput.test.tsx,components/v2/input/TotpInput.test.ts
