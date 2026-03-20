#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-21930
export REPO=sympy/sympy
export VERSION=1.9
export BASE_COMMIT=de446c6d85f633271dfec1452f6f28ea783e293f
export ENV_SETUP_COMMIT=f9a6f50ec0c74d935c50a6e9c9b2cb0469570d91
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES=sympy/physics/tests/test_secondquant.py
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
