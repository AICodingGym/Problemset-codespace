#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-14792
export REPO=django/django
export VERSION=4.0
export BASE_COMMIT=d89f976bddb49fb168334960acc8979c3de991fa
export ENV_SETUP_COMMIT=475cffd1d64c690cdad16ede4d5e81985738ceb4
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES=tests/utils_tests/test_timezone.py
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
