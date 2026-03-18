#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/agents/lastfm/agent_test.go tests/mock_user_props_repo.go 2>/dev/null || true" EXIT
git checkout ee21f3957e0de91624427e93c62b8ee390de72e3 -- core/agents/lastfm/agent_test.go tests/mock_user_props_repo.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi,TestServer,TestGravatar,TestCache,TestTranscoder,TestSpotify,TestScanner,TestLastFM,TestDB,TestNativeApi,TestPool,TestAgents,TestCore,TestEvents,TestPersistence
