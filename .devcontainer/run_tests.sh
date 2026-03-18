#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/agents/lastfm/agent_test.go core/agents/lastfm/client_test.go core/agents/listenbrainz/agent_test.go core/agents/listenbrainz/auth_router_test.go core/agents/listenbrainz/client_test.go core/agents/spotify/client_test.go 2>/dev/null || true" EXIT
git checkout 7073d18b54da7e53274d11c9e2baef1242e8769e -- core/agents/lastfm/agent_test.go core/agents/lastfm/client_test.go core/agents/listenbrainz/agent_test.go core/agents/listenbrainz/auth_router_test.go core/agents/listenbrainz/client_test.go core/agents/spotify/client_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestListenBrainz,TestSpotify,TestLastFM
