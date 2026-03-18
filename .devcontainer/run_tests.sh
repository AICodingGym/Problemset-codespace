#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tool/tsh/tsh_test.go 2>/dev/null || true" EXIT
git checkout 769b4b5eec7286b7b14e179f2cc52e6b15d2d9f3 -- tool/tsh/tsh_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMakeClient,TestReadClusterFlag,TestOptions/Incomplete_option,TestReadClusterFlag/nothing_set,TestFormatConnectCommand/no_default_user/database_are_specified,TestOptions/Forward_Agent_Local,TestFormatConnectCommand/unsupported_database_protocol,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_and_CLI_flag_is_set,_prefer_CLI,TestFetchDatabaseCreds,TestFormatConnectCommand/default_user_is_specified,TestOptions/Forward_Agent_No,TestOptions/Forward_Agent_InvalidValue,TestFormatConnectCommand/default_database_is_specified,TestReadClusterFlag/TELEPORT_SITE_set,TestOIDCLogin,TestRelogin,TestOptions/AddKeysToAgent_Invalid_Value,TestFormatConnectCommand/default_user/database_are_specified,TestOptions/Forward_Agent_Yes,TestFormatConnectCommand,TestOptions/Equals_Sign_Delimited,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_set,_prefer_TELEPORT_CLUSTER,TestOptions/Invalid_key,TestIdentityRead,TestOptions/Space_Delimited,TestReadClusterFlag/TELEPORT_CLUSTER_set,TestFailedLogin,TestOptions
