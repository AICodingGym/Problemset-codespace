#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/srv/db/sqlserver/protocol/fuzz_test.go 2>/dev/null || true" EXIT
git checkout 24cafecd8721891092210afc55f6413ab46ca211 -- lib/srv/db/sqlserver/protocol/fuzz_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) FuzzMSSQLLogin,FuzzMSSQLLogin/seed#6,FuzzMSSQLLogin/seed#1,FuzzMSSQLLogin/seed#3,FuzzMSSQLLogin/seed#7,FuzzMSSQLLogin/seed#4,FuzzMSSQLLogin/seed#5,FuzzMSSQLLogin/seed#2
