#!/bin/bash
set -e

if ! command -v helm &> /dev/null; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
fi

helm repo add gitlab https://charts.gitlab.io/
helm repo update
kubectl create ns gitlab
helm upgrade --install gitlab gitlab/gitlab -n gitlab -f bonus/confs/gitlab_values.yaml --timeout 30m --wait

PASSWORD=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath='{.data.password}' | base64 --decode)
echo "GitLab root password: $PASSWORD"

kubectl port-forward --address 0.0.0.0 -n gitlab svc/gitlab-webservice-default 8080:8181 &
sleep 10

echo ""
echo "✅ GitLab ready at http://localhost:8080"
echo "Login: root / $PASSWORD"
echo ""
echo "During defense:"
echo "1. Create project 'argocd-config'"
echo "2. Upload Part 3 manifests"
echo "3. Run: argocd repo add http://gitlab-webservice-default.gitlab.svc.cluster.local/root/argocd-config.git --username root --password $PASSWORD --insecure-skip-server-verification --name local-gitlab"
echo "4. Run: argocd app set wil-app --repo http://gitlab-webservice-default.gitlab.svc.cluster.local/root/argocd-config.git --path . --revision master"
