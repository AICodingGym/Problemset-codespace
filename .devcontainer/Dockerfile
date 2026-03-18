# Auto-generated devcontainer Dockerfile for native test execution
FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-dev \
    python-is-python3 \
    build-essential \
    pkg-config \
    libgl1 \
    libegl1 \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libasound2 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    libxcb-xfixes0 \
    libxcb-cursor0 \
    libxcb-shape0 \
    libxcb-util1 \
    libxcursor1 \
    libfontconfig1 \
    libfreetype6 \
    libx11-6 \
    libx11-xcb1 \
    libxext6 \
    libxrender1 \
    xvfb \
    x11-utils \
    dbus-x11 \
    libasound2-dev \
    libpulse-dev \
    fonts-liberation \
    fonts-dejavu-core \
    libxss1 \
    libxtst6 \
    libxrandr2 \
    libxfixes3 \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

