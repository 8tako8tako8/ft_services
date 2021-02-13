#!/bin/zsh
#portの使用状況確認sudo lsof -i -P | grep "LISTEN"
#apt-get install lftp　と　~/.lftprcの設定

minikube delete

minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-65535

eval $(minikube docker-env)

#metallbのインストール
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb/metallb-config.yaml

#イメージ作成
docker build -t kmorimot/influxdb_img ./srcs/influxdb
docker build -t kmorimot/grafana_img ./srcs/grafana
docker build -t kmorimot/mysql_img ./srcs/mysql
docker build -t kmorimot/phpmyadmin_img ./srcs/phpmyadmin
docker build -t kmorimot/nginx_img ./srcs/nginx
docker build -t kmorimot/wordpress_img ./srcs/wordpress
docker build -t kmorimot/ftps_img ./srcs/ftps

#pod作成
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml

#minikube dashboard