#!/bin/bash
set -e

sudo apt update
sudo apt install -y curl net-tools

MASTER_NODE_IP=$1

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="\
--node-ip=$MASTER_NODE_IP \
--advertise-address=$MASTER_NODE_IP \
--tls-san=$MASTER_NODE_IP \
" sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

echo NODE_TOKEN > /vagrant/token