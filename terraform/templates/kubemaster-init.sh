#!/bin/bash

sudo kubeadm init --pod-network-cidr 10.244.0.0/16 > /tmp/kubeadm_out.log
sleep 360
sudo kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

