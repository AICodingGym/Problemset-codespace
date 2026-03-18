#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/sshutils/scp/scp_test.go 2>/dev/null || true" EXIT
git checkout 007235446f85b1cbaef92664c3b3867517250f21 -- lib/sshutils/scp/scp_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestReceiveIntoNonExistingDirectoryFailsWithCorrectMessage
