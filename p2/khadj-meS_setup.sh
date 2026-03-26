#!/bin/bash

# Exporting Controle-plane IP
export CONTROL_PLANE_IP=192.168.56.110
echo "[PROVISION-LOG] Exported Control-plane IP -> CP_IP = $CONTROL_PLANE_IP"

# Install K3s on the master node
curl -sfL https://get.k3s.io | sh -s - --node-ip $CONTROL_PLANE_IP

# Make sure kubectl is set up for the vagrant user
echo "[PROVISION-LOG] Making kubectl not sudo only"
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config \
				/etc/rancher/k3s/k3s.yaml
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# Copying from source files
cp /vagrant/apps.yaml ./apps.yaml
echo "[PROVISION-LOG] Copied apps.yaml from host files"

# Appling the yaml file to make the depls
echo "[PROVISION-LOG] Launching deployements..."
kubectl apply -f apps.yaml

