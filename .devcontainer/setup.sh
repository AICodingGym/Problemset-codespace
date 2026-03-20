#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=astropy__astropy-7606
export REPO=astropy/astropy
export VERSION=1.3
export BASE_COMMIT=3cedd79e6c121910220f8e6df77c54a0b344ea94
export ENV_SETUP_COMMIT=848c8fa21332abd66b44efe3cb48b72377fb32cc
export TEST_CMD='pytest -rA -vv -o console_output_style=classic --tb=no'
export TEST_FILES=astropy/units/tests/test_units.py
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh"

# Git safe directory
git config --global --add safe.directory "$REPO_ROOT"

# Create conda environment and install dependencies
cat <<'ENV_EOF' > /tmp/environment.yml
name: testbed
channels:
  - defaults
  - conda-forge
dependencies:
  - _libgcc_mutex=0.1=main
  - _openmp_mutex=5.1=1_gnu
  - ca-certificates=2024.9.24=h06a4308_0
  - certifi=2021.5.30=py36h06a4308_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.3=he6710b0_2
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=1.1.1w=h7f8727e_0
  - pip=21.2.2=py36h06a4308_0
  - python=3.6.13=h12debd9_1
  - readline=8.2=h5eee18b_0
  - setuptools=38.2.4=py36_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - wheel=0.37.1=pyhd3eb1b0_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - apipkg==2.1.1
      - async-generator==1.10
      - attrs==17.3.0
      - contextvars==2.4
      - coverage==6.2
      - cython==0.27.3
      - exceptiongroup==0.0.0a0
      - execnet==1.5.0
      - hypothesis==3.44.2
      - idna==3.10
      - immutables==0.19
      - jinja2==2.10
      - markupsafe==1.0
      - numpy==1.16.0
      - outcome==1.0.0
      - packaging==16.8
      - pluggy==0.6.0
      - psutil==5.4.2
      - py==1.11.0
      - pyerfa==1.7.0
      - pyparsing==3.1.4
      - pytest==3.3.1
      - pytest-arraydiff==0.1
      - pytest-astropy==0.2.1
      - pytest-astropy-header==0.1
      - pytest-cov==2.5.1
      - pytest-doctestplus==0.1.2
      - pytest-filter-subpackage==0.1
      - pytest-forked==0.2
      - pytest-mock==1.6.3
      - pytest-openfiles==0.2.0
      - pytest-remotedata==0.2.0
      - pytest-xdist==1.20.1
      - pyyaml==3.12
      - six==1.16.0
      - sniffio==1.2.0
      - sortedcontainers==1.5.9
      - tomli==0.2.0
      - trio==0.8.0
      - typing-extensions==4.1.1
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install attrs==17.3.0 exceptiongroup==0.0.0a0 execnet==1.5.0 hypothesis==3.44.2 cython==0.27.3 jinja2==2.10 MarkupSafe==1.0 numpy==1.16.0 packaging==16.8 pluggy==0.6.0 psutil==5.4.2 pyerfa==1.7.0 pytest-arraydiff==0.1 pytest-astropy-header==0.1 pytest-astropy==0.2.1 pytest-cov==2.5.1 pytest-doctestplus==0.1.2 pytest-filter-subpackage==0.1 pytest-forked==0.2 pytest-mock==1.6.3 pytest-openfiles==0.2.0 pytest-remotedata==0.2.0 pytest-xdist==1.20.1 pytest==3.3.1 PyYAML==3.12 sortedcontainers==1.5.9 tomli==0.2.0

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
python -m pip install -e .[test] --verbose


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
