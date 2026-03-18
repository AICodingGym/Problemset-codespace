# Auto-generated devcontainer Dockerfile for native test execution
FROM ubuntu:20.04

# Environment variables (pre-apt)
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libffi-dev \
    libssl-dev \
    libyaml-dev \
    python3.9 \
    python3.9-dev \
    python3.9-venv \
    python3-pip \
    openssh-client \
    rsync \
    curl \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3.9 /usr/bin/python3 \
    && ln -sf /usr/bin/python3 /usr/bin/python

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

