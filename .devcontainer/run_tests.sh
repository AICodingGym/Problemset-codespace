#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=scikit-learn__scikit-learn-25973
export REPO=scikit-learn/scikit-learn
export VERSION=1.3
export BASE_COMMIT=10dbc142bd17ccf7bd38eec2ac04b52ce0d1009e
export ENV_SETUP_COMMIT=1e8a5b833d1b58f3ab84099c4582239af854b23a
export TEST_CMD='pytest -rA'
export TEST_FILES=sklearn/feature_selection/tests/test_sequential.py
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
