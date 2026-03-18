#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/service/service_test.go lib/service/state_test.go 2>/dev/null || true" EXIT
git checkout ba6c4a135412c4296dd5551bd94042f0dc024504 -- lib/service/service_test.go lib/service/state_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMonitor/ok_event_remains_in_recovering_state_because_not_enough_time_passed,TestProcessStateGetState/multiple_components,_one_is_recovering,TestProcessStateGetState/multiple_components,_one_is_degraded,TestMonitor/ok_event_in_new_component_causes_overall_OK_state,TestMonitor/ok_event_after_enough_time_causes_OK_state,TestMonitor,TestProcessStateGetState/one_component_in_stateOK,TestMonitor/ok_event_in_one_component_keeps_overall_status_degraded_due_to_other_component,TestMonitor/degraded_event_in_a_new_component_causes_degraded_state,TestMonitor/degraded_event_causes_degraded_state,TestProcessStateGetState/multiple_components,_one_is_starting,TestProcessStateGetState/no_components,TestMonitor/ok_event_in_new_component_causes_overall_recovering_state,TestProcessStateGetState/multiple_components_in_stateOK,TestProcessStateGetState,TestMonitor/ok_event_causes_recovering_state
