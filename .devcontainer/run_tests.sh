#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-18199
export REPO=sympy/sympy
export VERSION=1.6
export BASE_COMMIT=ba80d1e493f21431b4bf729b3e0452cd47eb9566
export ENV_SETUP_COMMIT=28b41c73c12b70d6ad9f6e45109a80649c4456da
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES='sympy/ntheory/tests/test_residue.py sympy/solvers/tests/test_solveset.py'
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
