# Auto-generated devcontainer Dockerfile for native test execution
FROM node:18

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3 \
    python3-pip \
    python3-setuptools \
    python-is-python3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install -y --no-install-recommends redis-server \
 && rm -rf /var/lib/apt/lists/*

# Environment variables
ENV SETUP='{ "url": "http://127.0.0.1:4567/forum", "secret": "abcdef", "admin:username": "admin", "admin:email": "test@example.org", "admin:password": "hAN3Eg8W", "admin:password:confirm": "hAN3Eg8W", "database": "redis", "redis:host": "127.0.0.1", "redis:port": 6379, "redis:password": "", "redis:database": 0 }'
ENV CI='{ "host": "127.0.0.1", "database": 1, "port": 6379 }'
ENV PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"
ENV UV_HTTP_TIMEOUT=60

# Install AI coding CLI tools
RUN (command -v npm && npm install -g @anthropic-ai/claude-code @openai/codex) || true
RUN pip install aicodinggym-cli || true

