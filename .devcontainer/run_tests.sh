#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=matplotlib__matplotlib-23314
export REPO=matplotlib/matplotlib
export VERSION=3.5
export BASE_COMMIT=97fc1154992f64cfb2f86321155a7404efeb2d8a
export ENV_SETUP_COMMIT=de98877e3dc45de8dd441d008f23d88738dc015d
export TEST_CMD='pytest -rA'
export TEST_FILES='lib/matplotlib/tests/test_axes.py lib/mpl_toolkits/tests/test_mplot3d.py'
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
