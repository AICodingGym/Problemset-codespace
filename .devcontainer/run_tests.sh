#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/backend/firestore/firestorebk_test.go lib/backend/test/suite.go lib/events/firestoreevents/firestoreevents_test.go 2>/dev/null || true" EXIT
git checkout 37c3724d0d6637e959e39408ee351565d73afe71 -- lib/backend/firestore/firestorebk_test.go lib/backend/test/suite.go lib/events/firestoreevents/firestoreevents_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFirestoreDB
