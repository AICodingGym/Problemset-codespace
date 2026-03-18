#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-playbook-callbacks/callbacks_list.expected test/integration/targets/handlers/handler_notify_earlier_handler.yml test/integration/targets/handlers/runme.sh test/integration/targets/old_style_vars_plugins/runme.sh test/units/executor/test_play_iterator.py test/units/plugins/strategy/test_linear.py 2>/dev/null || true" EXIT
git checkout d6d2251929c84c3aa883bad7db0f19cc9ff0339e -- test/integration/targets/ansible-playbook-callbacks/callbacks_list.expected test/integration/targets/handlers/handler_notify_earlier_handler.yml test/integration/targets/handlers/runme.sh test/integration/targets/old_style_vars_plugins/runme.sh test/units/executor/test_play_iterator.py test/units/plugins/strategy/test_linear.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/executor/test_play_iterator.py,test/units/plugins/strategy/test_linear.py
