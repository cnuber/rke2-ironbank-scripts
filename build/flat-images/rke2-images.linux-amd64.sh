#!/usr/bin/env bash
cd $(dirname $0)
docker build -t docker.io/rancher/hardened-calico:v3.13.3-amd64 docker.io/rancher/hardened-calico:v3.13.3-amd64
docker manifest create docker.io/rancher/hardened-calico:v3.13.3 docker.io/rancher/hardened-calico:v3.13.3-amd64
docker build -t docker.io/rancher/hardened-coredns:v1.6.9-amd64 docker.io/rancher/hardened-coredns:v1.6.9-amd64
docker manifest create docker.io/rancher/hardened-coredns:v1.6.9 docker.io/rancher/hardened-coredns:v1.6.9-amd64
docker build -t docker.io/rancher/hardened-etcd:v3.4.13-k3s1-amd64 docker.io/rancher/hardened-etcd:v3.4.13-k3s1-amd64
docker manifest create docker.io/rancher/hardened-etcd:v3.4.13-k3s1 docker.io/rancher/hardened-etcd:v3.4.13-k3s1-amd64
docker build -t docker.io/rancher/hardened-flannel:v0.13.0-rancher1-amd64 docker.io/rancher/hardened-flannel:v0.13.0-rancher1-amd64
docker manifest create docker.io/rancher/hardened-flannel:v0.13.0-rancher1 docker.io/rancher/hardened-flannel:v0.13.0-rancher1-amd64
docker build -t docker.io/rancher/hardened-k8s-metrics-server:v0.3.6-amd64 docker.io/rancher/hardened-k8s-metrics-server:v0.3.6-amd64
docker manifest create docker.io/rancher/hardened-k8s-metrics-server:v0.3.6 docker.io/rancher/hardened-k8s-metrics-server:v0.3.6-amd64
docker build -t docker.io/rancher/hardened-kube-proxy:v1.18.10-amd64 docker.io/rancher/hardened-kube-proxy:v1.18.10-amd64
docker manifest create docker.io/rancher/hardened-kube-proxy:v1.18.10 docker.io/rancher/hardened-kube-proxy:v1.18.10-amd64
docker build -t docker.io/rancher/klipper-helm:v0.3.0-amd64 docker.io/rancher/klipper-helm:v0.3.0-amd64
docker manifest create docker.io/rancher/klipper-helm:v0.3.0 docker.io/rancher/klipper-helm:v0.3.0-amd64
docker build -t docker.io/rancher/pause:3.2-amd64 docker.io/rancher/pause:3.2-amd64
docker manifest create docker.io/rancher/pause:3.2 docker.io/rancher/pause:3.2-amd64
docker build -t docker.io/rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1-amd64 docker.io/rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1-amd64
docker manifest create docker.io/rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1 docker.io/rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1-amd64
docker build -t docker.io/rancher/nginx-ingress-controller:nginx-0.30.0-rancher1-amd64 docker.io/rancher/nginx-ingress-controller:nginx-0.30.0-rancher1-amd64
docker manifest create docker.io/rancher/nginx-ingress-controller:nginx-0.30.0-rancher1 docker.io/rancher/nginx-ingress-controller:nginx-0.30.0-rancher1-amd64
docker build -t docker.io/rancher/rke2-runtime:v1.18.10-rke2r1-amd64 docker.io/rancher/rke2-runtime:v1.18.10-rke2r1-amd64
docker manifest create docker.io/rancher/rke2-runtime:v1.18.10-rke2r1 docker.io/rancher/rke2-runtime:v1.18.10-rke2r1-amd64
docker build -t docker.io/rancher/hardened-kubernetes:v1.18.10-rke2r1-amd64 docker.io/rancher/hardened-kubernetes:v1.18.10-rke2r1-amd64
docker manifest create docker.io/rancher/hardened-kubernetes:v1.18.10-rke2r1 docker.io/rancher/hardened-kubernetes:v1.18.10-rke2r1-amd64
