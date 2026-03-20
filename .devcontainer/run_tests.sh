#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-8120
export REPO=sphinx-doc/sphinx
export VERSION=3.3
export BASE_COMMIT=795747bdb6b8fb7d717d5bbfc2c3316869e66a73
export ENV_SETUP_COMMIT=3b85187ffa3401e88582073c23188c147857a8a3
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES=tests/test_intl.py
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
