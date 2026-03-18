#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/events/auditwriter_test.go lib/events/emitter_test.go lib/events/stream_test.go 2>/dev/null || true" EXIT
git checkout e6681abe6a7113cfd2da507f05581b7bdf398540 -- lib/events/auditwriter_test.go lib/events/emitter_test.go lib/events/stream_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestStreamerCompleteEmpty,TestAsyncEmitter/Receive,TestProtoStreamer/small_load_test_with_some_uneven_numbers,TestProtoStreamer/one_event_using_the_whole_part,TestWriterEmitter,TestAsyncEmitter/Slow,TestProtoStreamer/no_events,TestExport,TestAuditWriter,TestAsyncEmitter/Close,TestProtoStreamer/5MB_similar_to_S3_min_size_in_bytes,TestProtoStreamer,TestAuditWriter/ResumeMiddle,TestAsyncEmitter,TestAuditWriter/Backoff,TestAuditWriter/Session,TestAuditLog,TestAuditWriter/ResumeStart,TestProtoStreamer/get_a_part_per_message
