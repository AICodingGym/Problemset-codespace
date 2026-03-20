#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-9461
export REPO=sphinx-doc/sphinx
export VERSION=4.2
export BASE_COMMIT=939c7bb7ff7c53a4d27df067cea637540f0e1dad
export ENV_SETUP_COMMIT=336605b8e4b14c5da9f4d872fb730dc6894edb77
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-ext-autodoc/target/properties.py tests/test_domain_py.py tests/test_ext_autodoc_autoclass.py tests/test_ext_autodoc_autoproperty.py'
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
