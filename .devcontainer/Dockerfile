# Auto-generated devcontainer Dockerfile for native test execution
FROM ubuntu:20.04

# Environment variables (pre-apt)
ENV DEBIAN_FRONTEND=noninteractive

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    python-is-python3 \
    # Qt5 and GUI dependencies - avoid system PyQt5 to prevent conflicts

# Environment variables
ENV DISPLAY=:99
ENV QT_QPA_PLATFORM=offscreen
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

