#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/v2/phone/PhoneInput.test.tsx 2>/dev/null || true" EXIT
git checkout b387b24147e4b5ec3b482b8719ea72bee001462a -- packages/components/components/v2/phone/PhoneInput.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/v2/phone/PhoneInput.test.tsx,components/v2/phone/PhoneInput.test.ts
