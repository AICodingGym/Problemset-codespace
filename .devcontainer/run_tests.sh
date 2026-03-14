#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/modalTwo/ModalTwo.test.tsx 2>/dev/null || true" EXIT
git checkout e9677f6c46d5ea7d277a4532a4bf90074f125f31 -- packages/components/components/modalTwo/ModalTwo.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/modalTwo/ModalTwo.test.tsx,components/modalTwo/ModalTwo.test.ts
