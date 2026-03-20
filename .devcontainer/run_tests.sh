#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-7530
export REPO=django/django
export VERSION=1.11
export BASE_COMMIT=f8fab6f90233c7114d642dfe01a4e6d4cb14ee7d
export ENV_SETUP_COMMIT=3545e844885608932a692d952c12cd863e2320b5
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES=tests/migrations/test_commands.py
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh" || { echo "ERROR: conda not found — run setup.sh first"; exit 1; }
conda activate "$CONDA_ENV" || { echo "ERROR: conda env $CONDA_ENV not found — run setup.sh first"; exit 1; }

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYTHONIOENCODING=utf8
export LANGUAGE=en_US:en

echo "=== Running tests ==="
if echo "$TEST_CMD" | grep -q "runtests.py"; then
    # Django runtests.py requires dotted module names, not file paths
    MODULES=$(python3 -c 'import sys,re; print(" ".join(re.sub(r"\.py$","",re.sub(r"^tests/","",f)).replace("/",".") for f in sys.argv[1].split()))' "$TEST_FILES")
    $TEST_CMD $MODULES
else
    $TEST_CMD $TEST_FILES
fi
