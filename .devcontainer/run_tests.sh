#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/agents/lastfm_test.go 2>/dev/null || true" EXIT
git checkout b3980532237e57ab15b2b93c49d5cd5b2d050013 -- core/agents/lastfm_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAgents
