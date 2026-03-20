#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-9258
export REPO=sphinx-doc/sphinx
export VERSION=4.1
export BASE_COMMIT=06107f838c28ab6ca6bfc2cc208e15997fcb2146
export ENV_SETUP_COMMIT=9a2c3c4a1559e37e95fdee88c128bb116642c897
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES=tests/test_domain_py.py
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
