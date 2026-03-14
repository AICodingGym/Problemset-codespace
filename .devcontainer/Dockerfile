# Auto-generated devcontainer Dockerfile for native test execution
FROM ubuntu:20.04

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    python3 \
    python3-pip \
    python3-setuptools \
    python-is-python3 \
    chromium-browser \
    chromium-chromedriver \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

