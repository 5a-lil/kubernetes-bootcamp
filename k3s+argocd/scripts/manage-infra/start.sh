#!/bin/bash
set -e

echo "🚀 Creating k3d cluster..."
k3d cluster create my-cluster --port 8888:80@loadbalancer || true

echo "📦 Creating namespaces..."
kubectl create ns argocd || true
kubectl create ns dev || true

echo "🔧 Installing Argo CD (v2.14.17 to avoid race condition)..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.14.17/manifests/install.yaml

# ============================================
# FIX FOR THE SECRETKEY RACE CONDITION
# ============================================
echo "⏳ Waiting for initial Argo CD pods to be created..."
kubectl wait --for=condition=ready pod -n argocd --all --timeout=180s

echo "♻️  Restarting argocd-application-controller to resolve server.secretkey race condition..."
kubectl rollout restart statefulset argocd-application-controller -n argocd

echo "⏳ Waiting for controller restart to complete..."
kubectl rollout status statefulset argocd-application-controller -n argocd --timeout=120s

echo "⏳ Waiting for all pods to be ready after restart..."
kubectl wait --for=condition=ready pod -n argocd --all --timeout=120s
# ============================================

echo "📄 Applying Argo CD Application manifest..."
kubectl apply -f ./confs/argocd_setup.yaml

echo "⏳ Waiting for Application to be processed..."
sleep 15

echo "🔑 Getting Argo CD admin password..."
sleep 5
PSWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" 2>/dev/null | base64 -d)
if [ -z "$PSWD" ]; then
    echo "⚠️  Secret not ready yet. Waiting 10 more seconds..."
    sleep 10
    PSWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
fi
echo "Argocd password -> $PSWD"

echo "🌐 Waiting for application to be reachable at localhost:8888..."
until curl -s localhost:8888 | grep -q '"status":"ok"'; do 
    echo "waiting for the app to respond..."
    sleep 5
done

echo "✅ Application is ready! Starting port-forward..."
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8081:443
