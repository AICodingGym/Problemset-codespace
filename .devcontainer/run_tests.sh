#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tool/tsh/tsh_test.go 2>/dev/null || true" EXIT
git checkout 82185f232ae8974258397e121b3bc2ed0c3729ed -- tool/tsh/tsh_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFormatConnectCommand/default_user_is_specified,TestReadClusterFlag/TELEPORT_CLUSTER_set,TestOptions/Invalid_key,TestFailedLogin,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_set,_prefer_TELEPORT_CLUSTER,TestKubeConfigUpdate/invalid_selected_cluster,TestOptions/Incomplete_option,TestKubeConfigUpdate/selected_cluster,TestKubeConfigUpdate,TestKubeConfigUpdate/no_tsh_path,TestIdentityRead,TestOptions/Forward_Agent_Yes,TestOptions/Forward_Agent_InvalidValue,TestMakeClient,TestOptions/Equals_Sign_Delimited,TestReadClusterFlag/nothing_set,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_and_CLI_flag_is_set,_prefer_CLI,TestKubeConfigUpdate/no_kube_clusters,TestRelogin,TestOptions,TestKubeConfigUpdate/no_selected_cluster,TestFormatConnectCommand/default_user/database_are_specified,TestFormatConnectCommand/default_database_is_specified,TestFetchDatabaseCreds,TestOptions/Forward_Agent_Local,TestFormatConnectCommand/no_default_user/database_are_specified,TestOptions/AddKeysToAgent_Invalid_Value,TestOptions/Forward_Agent_No,TestOIDCLogin,TestReadClusterFlag,TestFormatConnectCommand/unsupported_database_protocol,TestOptions/Space_Delimited,TestReadClusterFlag/TELEPORT_SITE_set,TestFormatConnectCommand
