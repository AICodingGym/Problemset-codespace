#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=matplotlib__matplotlib-26291
export REPO=matplotlib/matplotlib
export VERSION=3.7
export BASE_COMMIT=fa68f46289adf4a8a4bc7ba97ded8258ec9d079c
export ENV_SETUP_COMMIT=0849036fd992a2dd133a0cffc3f84f58ccf1840f
export TEST_CMD='pytest -rA'
export TEST_FILES=lib/mpl_toolkits/axes_grid1/tests/test_axes_grid1.py
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
