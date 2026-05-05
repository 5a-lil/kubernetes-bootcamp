#!/bin/bash
helm uninstall gitlab -n gitlab
kubectl delete ns gitlab
helm repo remove gitlab
