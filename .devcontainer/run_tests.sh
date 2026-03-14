#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/popper/utils.test.ts 2>/dev/null || true" EXIT
git checkout e7f3f20c8ad86089967498632ace73c1157a9d51 -- packages/components/components/popper/utils.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/popper/utils.test.ts,components/popper/utils.test.ts
