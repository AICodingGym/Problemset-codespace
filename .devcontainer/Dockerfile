# Auto-generated devcontainer Dockerfile for native test execution
FROM python:3.12.2-slim

# System dependencies
RUN apt-get update && apt-get install -y wget gnupg \
    git \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    nodejs \
    npm \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y python3 python-is-python3

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

