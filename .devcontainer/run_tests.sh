#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/assistant/markdown.test.ts applications/mail/src/app/helpers/assistant/url.test.ts 2>/dev/null || true" EXIT
git checkout 281a6b3f190f323ec2c0630999354fafb84b2880 -- applications/mail/src/app/helpers/assistant/markdown.test.ts applications/mail/src/app/helpers/assistant/url.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/helpers/assistant/url.test.ts,src/app/helpers/assistant/markdown.test.ts,applications/mail/src/app/helpers/assistant/markdown.test.ts,applications/mail/src/app/helpers/assistant/url.test.ts
