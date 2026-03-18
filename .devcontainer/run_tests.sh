#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/client/api_test.go tool/tsh/proxy_test.go 2>/dev/null || true" EXIT
git checkout d873ea4fa67d3132eccba39213c1ca2f52064dcc -- lib/client/api_test.go tool/tsh/proxy_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSaveGetTrustedCerts,TestNewInsecureWebClientHTTPProxy,TestLocalKeyAgent_AddDatabaseKey,TestListKeys,TestNewClient_UseKeyPrincipals,TestKeyCRUD,TestKnownHosts,TestEndPlaybackWhilePaused,TestNewClientWithPoolHTTPProxy,TestClientAPI,TestHostCertVerification,TestDefaultHostPromptFunc,TestPruneOldHostKeys,TestMatchesWildcard,TestEmptyPlay,TestNewClientWithPoolNoProxy,TestParseSearchKeywords_SpaceDelimiter,TestMemLocalKeyStore,TestApplyProxySettings,TestConfigDirNotDeleted,TestAddKey_withoutSSHCert,TestParseSearchKeywords,TestWebProxyHostPort,TestProxySSHConfig,TestHostKeyVerification,TestStop,TestPlayPause,TestNewInsecureWebClientNoProxy,TestVirtualPathNames,TestEndPlaybackWhilePlaying,TestDeleteAll,TestLoadKey,TestCheckKey,TestCanPruneOldHostsEntry,TestParseKnownHost,TestPlainHttpFallback,TestIsOldHostsEntry,TestParseProxyHostString,TestAddKey,TestTeleportClient_Login_local
