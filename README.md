# ft_services

## Overview
Kubernetesを用いて７つのサービスをデプロイする。
alpineイメージから作成する制約あり。

## Requirement
- XUbuntu 18.04.5
- minikube v1.14.2
- kubectl v1.18.0
- docker v19.03.6

## Usage
```
git clone ...
cd ft_services
./setup.sh
ブラウザでhttp://192.168.49.200:80にアクセス
```

## Constitution
![image](https://user-images.githubusercontent.com/65395999/109416387-440a1700-7a01-11eb-88e4-6b8c15abe0b2.png)

### Welcome to ft_services(nginx)
<img width="584" alt="nginx" src="https://user-images.githubusercontent.com/65395999/115221209-64726a00-a144-11eb-9ab5-c5e5ae036be2.png">

### WordPress
- ブログ投稿サイト
<img width="582" alt="wp" src="https://user-images.githubusercontent.com/65395999/115219873-e497d000-a142-11eb-8b5c-80565052a5d6.png">

### phpMyAdmin
- MySQL管理用のダッシュボード
<img width="596" alt="pma" src="https://user-images.githubusercontent.com/65395999/115219907-ec577480-a142-11eb-962c-4f1854263937.png">

### Grafana
- 各podのCPU使用状況などがInfluxDBに保存されており、そのデータを可視化する。
<img width="594" alt="grafana" src="https://user-images.githubusercontent.com/65395999/115219918-eeb9ce80-a142-11eb-9218-93ffbc1ef8b8.png">

## About debug
略

## Reference
- [Hello Minikube](https://kubernetes.io/ja/docs/tutorials/hello-minikube/)
- [introduction-to-kubernetes](https://cybozu.github.io/introduction-to-kubernetes/introduction-to-kubernetes.html)
- [Kubernetes道場 Advent Calendar 2018](https://qiita.com/advent-calendar/2018/k8s-dojo)
- [Alpine Linux](https://wiki.alpinelinux.org/wiki/Main_Page)
