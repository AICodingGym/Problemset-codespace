#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-15127
export REPO=django/django
export VERSION=4.1
export BASE_COMMIT=9a6e2df3a8f01ea761529bec48e5a8dc0ea9575b
export ENV_SETUP_COMMIT=647480166bfe7532e8c471fef0146e3a17e6c0c9
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES='tests/messages_tests/base.py tests/messages_tests/tests.py'
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh" || { echo "ERROR: conda not found — run setup.sh first"; exit 1; }
conda activate "$CONDA_ENV" || { echo "ERROR: conda env $CONDA_ENV not found — run setup.sh first"; exit 1; }

echo "=== Running tests ==="
if echo "$TEST_CMD" | grep -q "runtests.py"; then
    # Django runtests.py requires dotted module names, not file paths
    MODULES=$(python3 -c 'import sys,re; print(" ".join(re.sub(r"\.py$","",re.sub(r"^tests/","",f)).replace("/",".") for f in sys.argv[1].split()))' "$TEST_FILES")
    $TEST_CMD $MODULES
else
    $TEST_CMD $TEST_FILES
fi
