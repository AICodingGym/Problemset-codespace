#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auditd/auditd_test.go 2>/dev/null || true" EXIT
git checkout 7744f72c6eb631791434b648ba41083b5f6d2278 -- lib/auditd/auditd_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSendEvent
