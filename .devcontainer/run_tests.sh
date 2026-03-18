#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/sshutils/x11/display_test.go 2>/dev/null || true" EXIT
git checkout 1b08e7d0dbe68fe530a0f08ad408ec198b7c53fc -- lib/sshutils/x11/display_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestDisplay,TestDisplay/unix_socket_full_path
