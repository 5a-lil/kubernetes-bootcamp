#!/bin/bash
k3d cluster create my-cluster --port 8888:80@loadbalancer
kubectl create ns argocd 
kubectl create ns dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ./argocd-app/myapp.yaml

echo "⏳ Waiting for Argo CD (2 mins)..."
kubectl wait --for=condition=ready pod -n argocd --selector=app.kubernetes.io/name=argocd-server --timeout=180s

PSWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "Argocd password -> $PSWD"

until curl -s localhost:8888 | grep -q '"status":"ok"'; do echo "waiting for the app to respond..."; sleep 2; done

kubectl port-forward svc/argocd-server -n argocd 8081:443
