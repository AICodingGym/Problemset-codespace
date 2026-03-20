#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-11510
export REPO=sphinx-doc/sphinx
export VERSION=7.2
export BASE_COMMIT=6cb783c0024a873722952a67ebb9f41771c8eb6d
export ENV_SETUP_COMMIT=7758e016231c3886e5a290c00fcb2c75d1f36c18
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-directive-include/baz/baz.rst tests/roots/test-directive-include/conf.py tests/roots/test-directive-include/foo.rst tests/roots/test-directive-include/text.txt tests/test_directive_other.py'
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
