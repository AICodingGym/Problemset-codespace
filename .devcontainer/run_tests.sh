#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=pydata__xarray-6992
export REPO=pydata/xarray
export VERSION=2022.06
export BASE_COMMIT=45c0a114e2b7b27b83c9618bc05b36afac82183c
export ENV_SETUP_COMMIT=50ea159bfd0872635ebf4281e741f3c87f0bef6b
export TEST_CMD='pytest -rA'
export TEST_FILES='xarray/tests/test_dataarray.py xarray/tests/test_dataset.py xarray/tests/test_groupby.py'
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
