#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/tlsca/ca_test.go 2>/dev/null || true" EXIT
git checkout 73cc189b0e9636d418c4470ecce0d9af5dae2f02 -- lib/tlsca/ca_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPrincipals/FromCertAndSigner,TestPrincipals,TestIdentity_ToFromSubject,TestPrincipals/FromTLSCertificate,TestKubeExtensions,TestIdentity_ToFromSubject/device_extensions,TestAzureExtensions,TestGCPExtensions,TestPrincipals/FromKeys,TestRenewableIdentity
