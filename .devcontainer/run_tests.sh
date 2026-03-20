#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=scikit-learn__scikit-learn-13439
export REPO=scikit-learn/scikit-learn
export VERSION=0.21
export BASE_COMMIT=a62775e99f2a5ea3d51db7160fad783f6cd8a4c5
export ENV_SETUP_COMMIT=7813f7efb5b2012412888b69e73d76f2df2b50b6
export TEST_CMD='pytest -rA'
export TEST_FILES=sklearn/tests/test_pipeline.py
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
