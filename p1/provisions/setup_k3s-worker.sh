#!/bin/bash
set -e

sudo apt update
sudo apt install -y curl net-tools

MASTER_NODE_IP=$1

echo "Waiting for master..."
until nc -z $MASTER_NODE_IP 6443; do
  sleep 2
done

NODE_TOKEN=$(sudo cat /vagrant/token)

curl -sfL https://get.k3s.io | \
K3S_URL="https://$MASTER_NODE_IP:6443" \
K3S_TOKEN="$NODE_TOKEN" \
sh -