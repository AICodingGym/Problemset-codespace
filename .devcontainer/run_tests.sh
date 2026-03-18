#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/kube/proxy/forwarder_test.go 2>/dev/null || true" EXIT
git checkout 96019ce0be7a2c8e36363f359eb7c943b41dde70 -- lib/kube/proxy/forwarder_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAuthenticate/local_user_and_remote_cluster,_no_tunnel,TestAuthenticate/unknown_kubernetes_cluster_in_local_cluster,TestAuthenticate
