#! /bin/sh
# install dependencies in the container

# Install dependencies and dev tools
sudo uv pip install --system --break-system-packages -r requirements.txt

# Setup pre-commit hooks
pre-commit install
