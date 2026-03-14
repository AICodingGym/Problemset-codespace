#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/members/multipleUserCreation/csv.test.ts 2>/dev/null || true" EXIT
git checkout 7e54526774e577c0ebb58ced7ba8bef349a69fec -- packages/components/containers/members/multipleUserCreation/csv.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/members/multipleUserCreation/csv.test.ts,containers/members/multipleUserCreation/csv.test.ts
