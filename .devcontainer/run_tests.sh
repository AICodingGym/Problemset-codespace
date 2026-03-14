#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/zustand/share/invitations.store.test.ts applications/drive/src/app/zustand/share/members.store.test.ts 2>/dev/null || true" EXIT
git checkout d8ff92b414775565f496b830c9eb6cc5fa9620e6 -- applications/drive/src/app/zustand/share/invitations.store.test.ts applications/drive/src/app/zustand/share/members.store.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/zustand/share/invitations.store.test.ts,applications/drive/src/app/zustand/share/members.store.test.ts,src/app/zustand/share/invitations.store.test.ts,src/app/zustand/share/members.store.test.ts
