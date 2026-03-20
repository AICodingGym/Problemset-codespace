#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-10614
export REPO=sphinx-doc/sphinx
export VERSION=7.2
export BASE_COMMIT=ac2b7599d212af7d04649959ce6926c63c3133fa
export ENV_SETUP_COMMIT=7758e016231c3886e5a290c00fcb2c75d1f36c18
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-ext-inheritance_diagram/conf.py tests/roots/test-ext-inheritance_diagram/index.rst tests/roots/test-ext-inheritance_diagram/subdir/index.rst tests/roots/test-ext-inheritance_diagram/subdir/other.py tests/roots/test-ext-inheritance_diagram/test.py tests/test_ext_inheritance_diagram.py'
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
