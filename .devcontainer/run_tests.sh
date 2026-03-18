#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/config/configuration_test.go 2>/dev/null || true" EXIT
git checkout fd2959260ef56463ad8afa4c973f47a50306edd4 -- lib/config/configuration_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestProxyKube/new_and_old_formats,TestProxyKube/legacy_format,_no_local_cluster,TestProxyKube/not_configured,TestProxyKube/legacy_format,_with_local_cluster,TestProxyKube,TestProxyKube/new_format_and_old_explicitly_disabled,TestProxyKube/new_format
