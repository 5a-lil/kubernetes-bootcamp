#!/bin/bash
set -e

echo "🗑️ UNINSTALL ALL Part 3 TOOLS"

# ========== DOCKER ===========
echo "💥 Docker - FULL REMOVAL..."
sudo systemctl stop docker || true
sudo systemctl disable docker || true

# Kill ALL Docker processes
sudo pkill dockerd || true
sudo pkill containerd || true

# Remove packages (CentOS/RHEL/Fedora)
sudo yum remove -y docker docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras || true
sudo dnf remove -y docker docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras || true

# Remove packages (Debian/Ubuntu)
sudo apt-get remove -y docker.io docker-ce docker-ce-cli containerd.io containerd runc docker-compose-plugin || true
sudo apt-get autoremove -y

# Delete binaries EVERYWHERE
sudo rm -f /usr/bin/docker /usr/local/bin/docker /usr/bin/containerd /usr/bin/ctr /usr/bin/runc

# Nuke ALL Docker data
docker system prune -a --volumes -f 2>/dev/null || true
sudo rm -rf /var/lib/docker /var/lib/containerd /etc/docker /etc/containerd ~/.docker

# ========== KUBECTL ==========
echo "☸️  kubectl..."
sudo rm -f /usr/local/bin/kubectl

# ========== K3D ==========
echo "☁️  k3d..."
if (k3d version && docker ps) > /dev/null 2>&1; then 
	k3d cluster delete --all 
fi
sudo rm -f /usr/local/bin/k3d

# ========== HELM ==========
# echo "📦 Helm..."
# rm -rf ~/.config/helm ~/.cache/helm
# sudo rm -f /usr/local/bin/helm

# ========== ARGOCD CLI ==========
echo "🔄 ArgoCD CLI..."
sudo rm -f /usr/local/bin/argocd

# ========== CLEANUP ==========
echo "🧹 Final cleanup..."
rm -rf ~/.kube/config ~/.k3d
docker system prune -af 2>/dev/null || true

echo "✅ ALL TOOLS UNINSTALLED"
echo "🔍 Verify: which kubectl k3d helm argocd docker"
