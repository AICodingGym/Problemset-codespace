#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=pytest-dev__pytest-7236
export REPO=pytest-dev/pytest
export VERSION=5.4
export BASE_COMMIT=c98bc4cd3d687fe9b392d8eecd905627191d4f06
export ENV_SETUP_COMMIT=678c1a0745f1cf175c442c719906a1f13e496910
export TEST_CMD='pytest -rA'
export TEST_FILES=testing/test_unittest.py
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
