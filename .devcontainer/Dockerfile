# Auto-generated devcontainer Dockerfile for native test execution
FROM node:18-bullseye

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-setuptools \
    python-is-python3 \
    build-essential \
    libsecret-1-dev \
    pkg-config \
    make \
    g++ \
    libc6-dev \
    xvfb \
    libgtk-3-0 \
    libgbm-dev \
    libnss3-dev \
    libxss1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

