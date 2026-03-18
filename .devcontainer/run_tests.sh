#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/srv/ingress/reporter_test.go 2>/dev/null || true" EXIT
git checkout b1bcd8b90c474a35bb11cc3ef4cc8941e1f8eab2 -- lib/srv/ingress/reporter_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestHTTPConnStateReporter,TestHTTPConnStateReporter/without_client_certs
