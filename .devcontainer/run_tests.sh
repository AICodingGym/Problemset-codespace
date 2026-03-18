#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/rooms/MessageComposer-test.tsx 2>/dev/null || true" EXIT
git checkout f14374a51c153f64f313243f2df6ea4971db4e15 -- test/components/views/rooms/MessageComposer-test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/rooms/MessageComposer-test.tsx,/app/test/components/views/rooms/MessageComposer-test.ts
