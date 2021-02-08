#!/bin/sh
kubectl delete --all services
kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all pvc
kubectl delete --all ingresses