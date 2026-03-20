#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-14248
export REPO=sympy/sympy
export VERSION=1.1
export BASE_COMMIT=9986b38181cdd556a3f3411e553864f11912244e
export ENV_SETUP_COMMIT=ec9e3c0436fbff934fa84e22bf07f1b3ef5bfac3
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES='sympy/printing/pretty/tests/test_pretty.py sympy/printing/tests/test_ccode.py sympy/printing/tests/test_fcode.py sympy/printing/tests/test_jscode.py sympy/printing/tests/test_julia.py sympy/printing/tests/test_latex.py sympy/printing/tests/test_octave.py sympy/printing/tests/test_rcode.py sympy/printing/tests/test_str.py'
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
