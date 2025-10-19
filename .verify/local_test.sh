#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="dotfiles-test"
DOCKERFILE=".verify/Dockerfile"

echo "🧱 Building Docker image..."
docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .

echo "🚀 Starting container..."
CONTAINER_ID=$(docker run -d -it "$IMAGE_NAME" sleep infinity)

echo "🔍 Running verification..."
docker exec -it "$CONTAINER_ID" bash -c "yes | /tmp/install.sh && /tmp/verify.sh"

echo "💻 Opening shell inside container..."
docker exec -it "$CONTAINER_ID" zsh

echo "🧹 Cleaning up..."
docker stop "$CONTAINER_ID" >/dev/null
docker rm "$CONTAINER_ID" >/dev/null

