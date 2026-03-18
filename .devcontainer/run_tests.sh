#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tool/tctl/common/auth_command_test.go 2>/dev/null || true" EXIT
git checkout 46a13210519461c7cec8d643bfbe750265775b41 -- tool/tctl/common/auth_command_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAuthSignKubeconfig/k8s_proxy_running_locally_with_public_addr,TestAuthSignKubeconfig/k8s_proxy_from_cluster_info,TestAuthSignKubeconfig/k8s_proxy_running_locally_without_public_addr,TestAuthSignKubeconfig
