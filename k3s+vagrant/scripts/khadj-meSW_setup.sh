#!/bin/bash
# Installing curl
sudo apt update && sudo apt install -y curl
# Get the master node's IP from the arguments
MASTER_IP=$1

# Get the token from the shared folder
TOKEN=$(cat /vagrant/token)

# Install K3s agent (worker) and join the master node
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$TOKEN sh -s - --node-ip 192.168.56.111
