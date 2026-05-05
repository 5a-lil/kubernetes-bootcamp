#!/bin/bash
set -e

VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -sLO "https://dl.k8s.io/release/$VER/bin/linux/amd64/kubectl"
curl -sLO "https://dl.k8s.io/release/$VER/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
chmod +x kubectl && \
sudo mv kubectl /usr/local/bin/ && \
sudo mv kubectl.sha256 .hidden-for-clarity
kubectl version --client
