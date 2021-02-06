#!/bin/sh
sudo kubectl delete --all services
sudo kubectl delete --all deployments
sudo kubectl delete --all pods
sudo kubectl delete --all pvc
sudo kubectl delete --all ingresses

