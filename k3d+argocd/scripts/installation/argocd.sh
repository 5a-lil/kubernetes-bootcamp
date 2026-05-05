#!/bin/bash
VER=$(curl -s https://api.github.com/repos/argoproj/argo-cd/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -sL -o argocd https://github.com/argoproj/argo-cd/releases/download/$VER/argocd-linux-amd64
sudo install -m 555 argocd /usr/local/bin/
rm argocd
argocd version --client --short
