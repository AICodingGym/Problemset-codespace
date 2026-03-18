#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/agents/lastfm/agent_test.go tests/mock_persistence.go tests/mock_user_props_repo.go 2>/dev/null || true" EXIT
git checkout 5001518260732e36d9a42fb8d4c054b28afab310 -- core/agents/lastfm/agent_test.go tests/mock_persistence.go tests/mock_user_props_repo.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestNativeApi,TestAgents,TestServer,TestSubsonicApi,TestPersistence,TestTranscoder,TestGravatar,TestPool,TestScanner,TestCache,TestLastFM,TestSpotify,TestEvents,TestCore
