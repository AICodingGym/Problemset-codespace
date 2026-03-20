#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-12489
export REPO=sympy/sympy
export VERSION=1.0
export BASE_COMMIT=aa9780761ad8c3c0f68beeef3a0ce5caac9e100b
export ENV_SETUP_COMMIT=50b81f9f6be151014501ffac44e5dc6b2416938f
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES=sympy/combinatorics/tests/test_permutations.py
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
