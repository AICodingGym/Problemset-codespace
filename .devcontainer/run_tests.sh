#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=pytest-dev__pytest-7521
export REPO=pytest-dev/pytest
export VERSION=6.0
export BASE_COMMIT=41d211c24a6781843b174379d6d6538f5c17adb9
export ENV_SETUP_COMMIT=634cde9506eb1f48dec3ec77974ee8dc952207c6
export TEST_CMD='pytest -rA'
export TEST_FILES=testing/test_capture.py
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
