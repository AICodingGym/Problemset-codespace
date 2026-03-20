#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=psf__requests-5414
export REPO=psf/requests
export VERSION=2.26
export BASE_COMMIT=39d0fdd9096f7dceccbc8f82e1eda7dd64717a8e
export ENV_SETUP_COMMIT=a1a6a549a0143d9b32717dbe3d75cd543ae5a4f6
export TEST_CMD='pytest -rA'
export TEST_FILES=tests/test_requests.py
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
  - exceptiongroup=1.2.0=py39h06a4308_0
  - iniconfig=1.1.1=pyhd3eb1b0_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - packaging=24.1=py39h06a4308_0
  - pip=24.2=py39h06a4308_0
  - pluggy=1.0.0=py39h06a4308_1
  - pytest=7.4.4=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - setuptools=75.1.0=py39h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tomli=2.0.1=py39h06a4308_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - certifi==2024.8.30
      - charset-normalizer==2.0.12
      - idna==3.10
      - urllib3==1.26.20
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
python -m pip install .


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
