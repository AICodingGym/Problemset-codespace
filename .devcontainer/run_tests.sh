#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-13449
export REPO=django/django
export VERSION=3.2
export BASE_COMMIT=2a55431a5678af52f669ffe7dff3dd0bd21727f8
export ENV_SETUP_COMMIT=65dfb06a1ab56c238cc80f5e1c31f61210c4577d
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES='tests/expressions_window/models.py tests/expressions_window/tests.py'
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh" || { echo "ERROR: conda not found — run setup.sh first"; exit 1; }
conda activate "$CONDA_ENV" || { echo "ERROR: conda env $CONDA_ENV not found — run setup.sh first"; exit 1; }

sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

echo "=== Running tests ==="
if echo "$TEST_CMD" | grep -q "runtests.py"; then
    # Django runtests.py requires dotted module names, not file paths
    MODULES=$(python3 -c 'import sys,re; print(" ".join(re.sub(r"\.py$","",re.sub(r"^tests/","",f)).replace("/",".") for f in sys.argv[1].split()))' "$TEST_FILES")
    $TEST_CMD $MODULES
else
    $TEST_CMD $TEST_FILES
fi
