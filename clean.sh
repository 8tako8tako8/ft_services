#!/bin/zsh
kubectl delete --all services
kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all pvc

minikube delete