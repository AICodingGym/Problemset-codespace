#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=astropy__astropy-13236
export REPO=astropy/astropy
export VERSION=5.0
export BASE_COMMIT=6ed769d58d89380ebaa1ef52b300691eefda8928
export ENV_SETUP_COMMIT=cdf311e0714e611d48b0a31eb1f0e2cbffab7f23
export TEST_CMD='pytest -rA'
export TEST_FILES='astropy/table/tests/test_mixin.py astropy/table/tests/test_table.py'
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
