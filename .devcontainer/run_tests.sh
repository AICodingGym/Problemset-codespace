#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/resumption/managedconn_test.go 2>/dev/null || true" EXIT
git checkout 4f771403dc4177dc26ee0370f7332f3fe54bee0f -- lib/resumption/managedconn_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestManagedConn/LocalClosed,TestManagedConn/RemoteClosed,TestManagedConn/WriteBuffering,TestManagedConn/Deadline,TestManagedConn,TestManagedConn/ReadBuffering,TestBuffer,TestManagedConn/Basic,TestDeadline
