#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=astropy__astropy-7606
export REPO=astropy/astropy
export VERSION=1.3
export BASE_COMMIT=3cedd79e6c121910220f8e6df77c54a0b344ea94
export ENV_SETUP_COMMIT=848c8fa21332abd66b44efe3cb48b72377fb32cc
export TEST_CMD='pytest -rA -vv -o console_output_style=classic --tb=no'
export TEST_FILES=astropy/units/tests/test_units.py
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
