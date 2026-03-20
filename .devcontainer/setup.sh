#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=astropy__astropy-8707
export REPO=astropy/astropy
export VERSION=3.1
export BASE_COMMIT=a85a0747c54bac75e9c3b2fe436b105ea029d6cf
export ENV_SETUP_COMMIT=2e89d074b3b2abc2da80e437c93b1d5516a0ca57
export TEST_CMD='pytest -rA'
export TEST_FILES=astropy/io/fits/tests/test_header.py
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
      - asttokens==2.4.1
      - attrs==23.1.0
      - certifi==2024.8.30
      - contourpy==1.3.0
      - coverage==7.6.2
      - cycler==0.12.1
      - decorator==5.1.1
      - exceptiongroup==1.1.3
      - execnet==2.0.2
      - executing==2.1.0
      - fonttools==4.54.1
      - hypothesis==6.82.6
      - importlib-resources==6.4.5
      - iniconfig==2.0.0
      - ipython==8.18.1
      - jedi==0.19.1
      - jinja2==3.1.4
      - jplephem==2.22
      - kiwisolver==1.4.7
      - markupsafe==3.0.2
      - matplotlib==3.9.2
      - matplotlib-inline==0.1.7
      - numpy==1.25.2
      - objgraph==3.6.2
      - packaging==23.1
      - parso==0.8.4
      - pexpect==4.9.0
      - pillow==11.0.0
      - pluggy==1.3.0
      - prompt-toolkit==3.0.48
      - psutil==5.9.5
      - ptyprocess==0.7.0
      - pure-eval==0.2.3
      - pyerfa==2.0.0.3
      - pygments==2.18.0
      - pyparsing==3.2.0
      - pytest==7.4.0
      - pytest-arraydiff==0.5.0
      - pytest-astropy==0.10.0
      - pytest-astropy-header==0.2.2
      - pytest-cov==4.1.0
      - pytest-doctestplus==1.0.0
      - pytest-filter-subpackage==0.1.2
      - pytest-mock==3.11.1
      - pytest-mpl==0.17.0
      - pytest-openfiles==0.5.0
      - pytest-remotedata==0.4.0
      - pytest-xdist==3.3.1
      - python-dateutil==2.9.0.post0
      - pyyaml==6.0.1
      - setuptools==68.0.0
      - sgp4==2.23
      - six==1.16.0
      - skyfield==1.49
      - sortedcontainers==2.4.0
      - stack-data==0.6.3
      - tomli==2.0.1
      - traitlets==5.14.3
      - typing-extensions==4.12.2
      - wcwidth==0.2.13
      - zipp==3.20.2
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install attrs==23.1.0 exceptiongroup==1.1.3 execnet==2.0.2 hypothesis==6.82.6 iniconfig==2.0.0 numpy==1.25.2 packaging==23.1 pluggy==1.3.0 psutil==5.9.5 pyerfa==2.0.0.3 pytest-arraydiff==0.5.0 pytest-astropy-header==0.2.2 pytest-astropy==0.10.0 pytest-cov==4.1.0 pytest-doctestplus==1.0.0 pytest-filter-subpackage==0.1.2 pytest-mock==3.11.1 pytest-openfiles==0.5.0 pytest-remotedata==0.4.0 pytest-xdist==3.3.1 pytest==7.4.0 PyYAML==6.0.1 setuptools==68.0.0 sortedcontainers==2.4.0 tomli==2.0.1

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
