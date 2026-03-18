#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tool/tsh/tsh_test.go 2>/dev/null || true" EXIT
git checkout db89206db6c2969266e664c7c0fb51b70e958b64 -- tool/tsh/tsh_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestIdentityRead,TestFormatConnectCommand/default_user/database_are_specified,TestFormatConnectCommand/unsupported_database_protocol,TestOIDCLogin,TestFormatConnectCommand/default_user_is_specified,TestReadClusterFlag,TestOptions,TestFormatConnectCommand/default_database_is_specified,TestReadClusterFlag/nothing_set,TestFormatConnectCommand,TestMakeClient,TestFormatConnectCommand/no_default_user/database_are_specified,TestReadClusterFlag/TELEPORT_SITE_set,TestReadClusterFlag/TELEPORT_CLUSTER_set,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_set,_prefer_TELEPORT_CLUSTER,TestReadClusterFlag/TELEPORT_SITE_and_TELEPORT_CLUSTER_and_CLI_flag_is_set,_prefer_CLI,TestFetchDatabaseCreds
