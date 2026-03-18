#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/players_test.go persistence/persistence_suite_test.go persistence/persistence_test.go persistence/player_repository_test.go 2>/dev/null || true" EXIT
git checkout fa85e2a7816a6fe3829a4c0d8e893e982b0985da -- core/players_test.go persistence/persistence_suite_test.go persistence/persistence_test.go persistence/player_repository_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCore,TestPersistence
