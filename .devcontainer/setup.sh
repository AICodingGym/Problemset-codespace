#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-9258
export REPO=sphinx-doc/sphinx
export VERSION=4.1
export BASE_COMMIT=06107f838c28ab6ca6bfc2cc208e15997fcb2146
export ENV_SETUP_COMMIT=9a2c3c4a1559e37e95fdee88c128bb116642c897
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES=tests/test_domain_py.py
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
  - setuptools=75.1.0=py39h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - alabaster==0.7.11
      - babel==2.16.0
      - cachetools==5.5.0
      - certifi==2024.8.30
      - chardet==5.2.0
      - charset-normalizer==3.4.0
      - colorama==0.4.6
      - coverage==7.6.4
      - cython==3.0.11
      - distlib==0.3.9
      - docutils==0.17.1
      - exceptiongroup==1.2.2
      - filelock==3.16.1
      - html5lib==1.1
      - idna==3.10
      - imagesize==1.4.1
      - iniconfig==2.0.0
      - jinja2==2.11.3
      - markupsafe==2.0.1
      - packaging==24.1
      - platformdirs==4.3.6
      - pluggy==1.5.0
      - pygments==2.18.0
      - pyproject-api==1.8.0
      - pytest==8.3.3
      - pytest-cov==5.0.0
      - requests==2.32.3
      - six==1.16.0
      - snowballstemmer==2.2.0
      - tomli==2.0.2
      - tox==4.16.0
      - tox-current-env==0.0.11
      - urllib3==2.2.3
      - virtualenv==20.26.6
      - webencodings==0.5.1
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install tox==4.16.0 tox-current-env==0.0.11 Jinja2==3.0.3

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
sed -i 's/pytest/pytest -rA/' tox.ini
sed -i 's/Jinja2>=2.3/Jinja2<3.0/' setup.py
sed -i 's/sphinxcontrib-applehelp/sphinxcontrib-applehelp<=1.0.7/' setup.py
sed -i 's/sphinxcontrib-devhelp/sphinxcontrib-devhelp<=1.0.5/' setup.py
sed -i 's/sphinxcontrib-qthelp/sphinxcontrib-qthelp<=1.0.6/' setup.py
sed -i 's/alabaster>=0.7,<0.8/alabaster>=0.7,<0.7.12/' setup.py
sed -i "s/'packaging',/'packaging', 'markupsafe<=2.0.1',/" setup.py
grep -q 'sphinxcontrib-htmlhelp>=2.0.0' setup.py && sed -i 's/sphinxcontrib-htmlhelp>=2.0.0/sphinxcontrib-htmlhelp>=2.0.0,<=2.0.4/' setup.py || sed -i 's/sphinxcontrib-htmlhelp/sphinxcontrib-htmlhelp<=2.0.4/' setup.py
grep -q 'sphinxcontrib-serializinghtml>=1.1.5' setup.py && sed -i 's/sphinxcontrib-serializinghtml>=1.1.5/sphinxcontrib-serializinghtml>=1.1.5,<=1.1.9/' setup.py || sed -i 's/sphinxcontrib-serializinghtml/sphinxcontrib-serializinghtml<=1.1.9/' setup.py
python -m pip install -e .[test]


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
