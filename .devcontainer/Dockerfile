# Auto-generated devcontainer Dockerfile for native test execution
FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    bash \
    make \
    gcc \
    libffi-dev \
    libssl-dev \
    python-is-python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

