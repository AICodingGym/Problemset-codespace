#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-24066
export REPO=sympy/sympy
export VERSION=1.12
export BASE_COMMIT=514579c655bf22e2af14f0743376ae1d7befe345
export ENV_SETUP_COMMIT=c6cb7c5602fa48034ab1bd43c2347a7e8488f12e
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES=sympy/physics/units/tests/test_quantities.py
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
