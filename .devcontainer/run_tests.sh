#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/backend/kubernetes/kubernetes_test.go 2>/dev/null || true" EXIT
git checkout 3a5c1e26394df2cb4fb3f01147fb9979662972c5 -- lib/backend/kubernetes/kubernetes_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestBackend_Exists/secret_exists,TestBackend_Put/secret_exists_and_has_keys,TestBackend_Get/secret_exists_and_key_is_present_but_empty,TestBackend_Get/secret_exists_but_key_not_present,TestBackend_Put,TestBackend_Exists/secret_exists_but_generates_an_error_because_TELEPORT_REPLICA_NAME_is_not_set,TestBackend_Put/secret_does_not_exist_and_should_be_created,TestBackend_Get/secret_exists_and_key_is_present,TestBackend_Exists/secret_exists_but_generates_an_error_because_KUBE_NAMESPACE_is_not_set,TestBackend_Get/secret_does_not_exist,TestBackend_Exists,TestBackend_Exists/secret_does_not_exist,TestBackend_Get
