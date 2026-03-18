# Auto-generated devcontainer Dockerfile for native test execution
FROM python:3.9-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libglib2.0-0 \
    libgl1 \
    libegl1 \
    libxkbcommon0 \
    libdbus-1-3 \
    libxcomposite1 \
    libxdamage1 \
    libxi6 \
    libxrandr2 \
    libxfixes3 \
    libxcursor1 \
    libxrender1 \
    libxext6 \
    xvfb \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    libxslt1.1 \
    fonts-liberation2 \
    libxcb1 \
    libxkbcommon-x11-0 \
    libgl1 \
    dbus-x11 \
    python3 \
    python-is-python3 \
    libfontconfig1 \
    libxkbcommon0 \
    libegl1 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

