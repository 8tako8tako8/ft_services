#!/bin/zsh
kubectl delete --all services
kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all pvc

minikube delete

#ssh-keygen -f "/home/user42/.ssh/known_hosts" -R "192.168.49.200"