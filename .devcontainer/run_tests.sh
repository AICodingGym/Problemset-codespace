#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-7985
export REPO=sphinx-doc/sphinx
export VERSION=3.2
export BASE_COMMIT=f30284ef926ebaf04b176f21b421e2dffc679792
export ENV_SETUP_COMMIT=f92fa6443fe6f457ab0c26d41eb229e825fda5e1
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-linkcheck/links.txt tests/test_build_linkcheck.py'
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
