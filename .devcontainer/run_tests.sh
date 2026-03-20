#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=scikit-learn__scikit-learn-14710
export REPO=scikit-learn/scikit-learn
export VERSION=0.22
export BASE_COMMIT=4b6273b87442a4437d8b3873ea3022ae163f4fdf
export ENV_SETUP_COMMIT=7e85a6d1f038bbb932b36f18d75df6be937ed00d
export TEST_CMD='pytest -rA'
export TEST_FILES=sklearn/ensemble/_hist_gradient_boosting/tests/test_gradient_boosting.py
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
