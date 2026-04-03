#!/bin/bash
set -e

echo "🐳 Installing Docker ONLY..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "📦 Docker install..."
curl -fsSL https://get.docker.com | sudo sh

# Enable & start
sudo systemctl enable --now docker

# Add user to docker group
sudo usermod -aG docker $USER

echo "✅ Docker installed!"
echo "🔄 Logout/login or run 'newgrp docker' to use without sudo"

docker version
