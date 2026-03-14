#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/v2/addressesAutomplete/AddressesAutocomplete.helper.test.ts packages/shared/lib/mail/recipient.test.ts 2>/dev/null || true" EXIT
git checkout cfd7571485186049c10c822f214d474f1edde8d1 -- packages/components/components/v2/addressesAutomplete/AddressesAutocomplete.helper.test.ts packages/shared/lib/mail/recipient.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/v2/addressesAutomplete/AddressesAutocomplete.helper.test.ts,packages/shared/lib/mail/recipient.test.ts,components/v2/addressesAutomplete/AddressesAutocomplete.helper.test.ts
