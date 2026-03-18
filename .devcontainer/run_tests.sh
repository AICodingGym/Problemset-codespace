#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/reversetunnel/localsite_test.go 2>/dev/null || true" EXIT
git checkout 02d1efb8560a1aa1c72cfb1c08edd8b84a9511b4 -- lib/reversetunnel/localsite_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAgentStoreRace,TestCachingResolver,TestAgentStorePopLen,TestEmitConnTeleportSmallReads,TestAgentFailedToClaimLease,TestAgentCertChecker,TestAgentStart,Test_remoteSite_getLocalWatchedCerts,TestStaticResolver,TestLocalSiteOverlap,TestRemoteClusterTunnelManagerSync,TestServerKeyAuth,TestCreateRemoteAccessPoint,TestConnectedProxyGetter,TestAgentStateTransitions,TestEmitConnTeleport,TestAgentPoolConnectionCount,TestEmitConnNotTeleportSmallReads,TestEmitConnNotTeleport,TestResolveViaWebClient
