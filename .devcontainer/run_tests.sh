#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- persistence/album_repository_test.go persistence/artist_repository_test.go persistence/genre_repository_test.go persistence/mediafile_repository_test.go persistence/persistence_suite_test.go persistence/playlist_repository_test.go persistence/playqueue_repository_test.go persistence/property_repository_test.go persistence/radio_repository_test.go persistence/sql_bookmarks_test.go persistence/user_repository_test.go 2>/dev/null || true" EXIT
git checkout 55bff343cdaad1f04496f724eda4b55d422d7f17 -- persistence/album_repository_test.go persistence/artist_repository_test.go persistence/genre_repository_test.go persistence/mediafile_repository_test.go persistence/persistence_suite_test.go persistence/playlist_repository_test.go persistence/playqueue_repository_test.go persistence/property_repository_test.go persistence/radio_repository_test.go persistence/sql_bookmarks_test.go persistence/user_repository_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPersistence
