#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/replace_test.go 2>/dev/null || true" EXIT
git checkout 47530e1fd8bfb84ec096ebcbbc29990f30829655 -- lib/utils/replace_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestKubeResourceMatchesRegex/namespace_granting_read_access_to_pod,TestKubeResourceMatchesRegex,TestKubeResourceMatchesRegex/list_namespace_with_resource_giving_read_access_to_namespace
