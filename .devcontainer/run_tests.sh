#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/blocks/72725.yml test/integration/targets/blocks/72781.yml test/integration/targets/blocks/runme.sh test/integration/targets/handlers/46447.yml test/integration/targets/handlers/52561.yml test/integration/targets/handlers/54991.yml test/integration/targets/handlers/include_handlers_fail_force-handlers.yml test/integration/targets/handlers/include_handlers_fail_force.yml test/integration/targets/handlers/order.yml test/integration/targets/handlers/runme.sh test/integration/targets/handlers/test_flush_handlers_as_handler.yml test/integration/targets/handlers/test_flush_handlers_rescue_always.yml test/integration/targets/handlers/test_flush_in_rescue_always.yml test/integration/targets/handlers/test_handlers_infinite_loop.yml test/integration/targets/handlers/test_handlers_meta.yml test/integration/targets/handlers/test_skip_flush.yml test/units/plugins/strategy/test_linear.py test/units/plugins/strategy/test_strategy.py 2>/dev/null || true" EXIT
git checkout 811093f0225caa4dd33890933150a81c6a6d5226 -- test/integration/targets/blocks/72725.yml test/integration/targets/blocks/72781.yml test/integration/targets/blocks/runme.sh test/integration/targets/handlers/46447.yml test/integration/targets/handlers/52561.yml test/integration/targets/handlers/54991.yml test/integration/targets/handlers/include_handlers_fail_force-handlers.yml test/integration/targets/handlers/include_handlers_fail_force.yml test/integration/targets/handlers/order.yml test/integration/targets/handlers/runme.sh test/integration/targets/handlers/test_flush_handlers_as_handler.yml test/integration/targets/handlers/test_flush_handlers_rescue_always.yml test/integration/targets/handlers/test_flush_in_rescue_always.yml test/integration/targets/handlers/test_handlers_infinite_loop.yml test/integration/targets/handlers/test_handlers_meta.yml test/integration/targets/handlers/test_skip_flush.yml test/units/plugins/strategy/test_linear.py test/units/plugins/strategy/test_strategy.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/strategy/test_linear.py,test/units/plugins/strategy/test_strategy.py
