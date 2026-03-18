# Auto-generated devcontainer Dockerfile for native test execution
FROM python:3.11.1-slim

# Environment variables (pre-apt)
ENV LANG en_US.UTF-8
ENV LC_ALL POSIX

# System dependencies
RUN apt-get -qq update && apt-get install -y \
    postgresql-client \
    build-essential \
    git \
    libpq-dev \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    curl \
    python3 \
    python-is-python3 \
    parallel \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

