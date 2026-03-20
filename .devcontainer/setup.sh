#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=pylint-dev__pylint-8898
export REPO=pylint-dev/pylint
export VERSION=3.0
export BASE_COMMIT=1f8c4d9eb185c16a2c1d881c054f015e1c2eb334
export ENV_SETUP_COMMIT=a0ce6e424e3a208f3aed1cbf6e16c40853bec3c0
export TEST_CMD='pytest -rA'
export TEST_FILES=tests/config/test_config.py
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
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - pip=24.2=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - astroid==3.0.3
      - cachetools==5.5.0
      - certifi==2024.8.30
      - chardet==5.2.0
      - charset-normalizer==3.4.0
      - cli-ui==0.17.2
      - click==8.1.7
      - colorama==0.4.6
      - contributors-txt==1.0.0
      - coverage==7.6.4
      - dill==0.3.9
      - distlib==0.3.9
      - docopt==0.6.2
      - exceptiongroup==1.2.2
      - execnet==2.1.1
      - filelock==3.16.1
      - gprof2dot==2024.6.6
      - idna==3.10
      - importlib-resources==6.4.5
      - incremental==22.10.0
      - iniconfig==2.0.0
      - isort==5.13.2
      - jinja2==3.1.4
      - markupsafe==3.0.2
      - mccabe==0.7.0
      - packaging==24.1
      - platformdirs==4.3.6
      - pluggy==1.5.0
      - py==1.11.0
      - py-cpuinfo==9.0.0
      - pyproject-api==1.8.0
      - pytest==7.4.4
      - pytest-benchmark==4.0.0
      - pytest-cov==4.1.0
      - pytest-profiling==1.7.0
      - pytest-timeout==2.3.1
      - pytest-xdist==3.6.1
      - requests==2.32.3
      - schema==0.7.7
      - setuptools==41.6.0
      - six==1.16.0
      - tabulate==0.8.10
      - tbump==6.10.0
      - tomli==2.0.2
      - tomlkit==0.11.8
      - towncrier==23.11.0
      - tox==4.23.2
      - types-pkg-resources==0.1.3
      - typing-extensions==4.12.2
      - unidecode==1.3.8
      - urllib3==2.2.3
      - virtualenv==20.27.0
      - zipp==3.20.2
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install astroid==3.0.0a6 setuptools

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
python -m pip install -e .


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
