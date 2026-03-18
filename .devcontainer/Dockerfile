# Auto-generated devcontainer Dockerfile for native test execution
FROM golang:1.23

# System dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    pkg-config \
    build-essential \
    cmake \
    g++ \
    zlib1g-dev \
    libutfcpp-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

