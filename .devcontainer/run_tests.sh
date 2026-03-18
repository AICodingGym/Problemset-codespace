#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tool/tctl/common/auth_command_test.go 2>/dev/null || true" EXIT
git checkout 288c5519ce0dec9622361a5e5d6cd36aa2d9e348 -- tool/tctl/common/auth_command_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAuthSignKubeconfig/k8s_proxy_running_locally_without_public_addr,TestAuthSignKubeconfig/--kube-cluster_specified_with_invalid_cluster,TestDatabaseServerResource/get_specific_database_server,TestAuthSignKubeconfig/--kube-cluster_specified_with_valid_cluster,TestGenerateDatabaseKeys/database_certificate,TestCheckKubeCluster/local_cluster,_empty_kube_cluster,TestCheckKubeCluster/remote_cluster,_empty_kube_cluster,TestTrimDurationSuffix/trim_minutes/seconds,TestCheckKubeCluster/local_cluster,_invalid_kube_cluster,TestAuthSignKubeconfig/k8s_proxy_running_locally_with_public_addr,TestTrimDurationSuffix,TestDatabaseResource,TestTrimDurationSuffix/trim_seconds,TestTrimDurationSuffix/does_not_trim_non-zero_suffix,TestGenerateDatabaseKeys/mongodb_certificate,TestAppResource,TestDatabaseServerResource/get_all_database_servers,TestCheckKubeCluster/local_cluster,_valid_kube_cluster,TestCheckKubeCluster/local_cluster,_empty_kube_cluster,_no_registered_kube_clusters,TestAuthSignKubeconfig/--proxy_specified,TestCheckKubeCluster,TestGenerateDatabaseKeys/database_certificate_multiple_SANs,TestAuthSignKubeconfig/k8s_proxy_from_cluster_info,TestCheckKubeCluster/non-k8s_output_format,TestGenerateDatabaseKeys,TestCheckKubeCluster/remote_cluster,_non-empty_kube_cluster,TestDatabaseServerResource,TestTrimDurationSuffix/does_not_trim_zero_in_the_middle,TestAuthSignKubeconfig,TestDatabaseServerResource/remove_database_server
