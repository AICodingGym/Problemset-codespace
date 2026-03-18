#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/events/auditlog_test.go lib/events/filesessions/fileasync_chaos_test.go lib/events/filesessions/fileasync_test.go 2>/dev/null || true" EXIT
git checkout c1b1c6a1541c478d7777a48fca993cc8206c73b9 -- lib/events/auditlog_test.go lib/events/filesessions/fileasync_chaos_test.go lib/events/filesessions/fileasync_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAuditWriter/Session,TestProtoStreamer/5MB_similar_to_S3_min_size_in_bytes,TestProtoStreamer,TestAuditWriter/ResumeMiddle,TestProtoStreamer/no_events,TestProtoStreamer/one_event_using_the_whole_part,TestAuditWriter/ResumeStart,TestAuditLog,TestAuditWriter,TestProtoStreamer/small_load_test_with_some_uneven_numbers,TestProtoStreamer/get_a_part_per_message
