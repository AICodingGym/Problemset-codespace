#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/auth/auth_test.go 2>/dev/null || true" EXIT
git checkout 0415e422f12454db0c22316cf3eaa5088d6b6322 -- lib/auth/auth_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestUpsertServer/auth,TestMFADeviceManagement/add_a_U2F_device,TestUpsertServer,TestMFADeviceManagement/add_initial_TOTP_device,TestMFADeviceManagement/fail_TOTP_auth_challenge,TestMiddlewareGetUser/local_system_role,TestRemoteClusterStatus,TestMiddlewareGetUser/local_user_no_teleport_cluster_in_cert_subject,TestMFADeviceManagement,TestMFADeviceManagement/delete_last_U2F_device_by_ID,TestMiddlewareGetUser,TestU2FSignChallengeCompat,TestMiddlewareGetUser/no_client_cert,TestU2FSignChallengeCompat/new_client,_old_server,TestMiddlewareGetUser/remote_system_role,TestMFADeviceManagement/fail_a_U2F_auth_challenge,TestMFADeviceManagement/fail_a_TOTP_registration_challenge,TestMFADeviceManagement/fail_a_TOTP_auth_challenge,TestMiddlewareGetUser/remote_user,TestMiddlewareGetUser/local_user,TestMFADeviceManagement/fail_a_U2F_registration_challenge,TestMFADeviceManagement/delete_TOTP_device_by_name,TestMigrateMFADevices,TestUpsertServer/node,TestUpsertServer/unknown,TestU2FSignChallengeCompat/old_client,_new_server,TestMFADeviceManagement/fail_to_delete_an_unknown_device,TestUpsertServer/proxy,TestMiddlewareGetUser/remote_user_no_teleport_cluster_in_cert_subject,TestMFADeviceManagement/fail_U2F_auth_challenge
