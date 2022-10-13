#!/bin/bash

cd $HOME/software/
wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
tar xvf containerd-1.6.8-linux-amd64.tar.gz -C /usr/local/
rm containerd-1.6.8-linux-amd64.tar.gz

mkdir -p /usr/local/lib/systemd/system/
wget -O /usr/local/lib/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

systemctl daemon-reload
systemctl enable --now containerd
