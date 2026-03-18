#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/oci/ecr/credentials_store_test.go internal/oci/ecr/ecr_test.go internal/oci/ecr/mock_Client_test.go internal/oci/ecr/mock_PrivateClient_test.go internal/oci/ecr/mock_PublicClient_test.go internal/oci/file_test.go 2>/dev/null || true" EXIT
git checkout 96820c3ad10b0b2305e8877b6b303f7fafdf815f -- internal/oci/ecr/credentials_store_test.go internal/oci/ecr/ecr_test.go internal/oci/ecr/mock_Client_test.go internal/oci/ecr/mock_PrivateClient_test.go internal/oci/ecr/mock_PublicClient_test.go internal/oci/file_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestStore_List,TestFile,TestWithCredentials,TestStore_Fetch_InvalidMediaType,TestStore_FetchWithECR,TestAuthenicationTypeIsValid,TestParseReference,TestStore_Fetch,TestECRCredential,TestStore_Copy,TestPrivateClient,TestDefaultClientFunc,TestWithManifestVersion,TestCredential,TestPublicClient,TestStore_Build
