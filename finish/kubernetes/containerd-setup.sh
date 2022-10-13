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

mkdir -p /etc/cni/net.d/
cat << EOF | tee /etc/cni/net.d/10-containerd-net.conflist
{
 "cniVersion": "1.0.0",
 "name": "containerd-net",
 "plugins": [
   {
     "type": "bridge",
     "bridge": "cni0",
     "isGateway": true,
     "ipMasq": true,
     "promiscMode": true,
     "ipam": {
       "type": "host-local",
       "ranges": [
         [{
           "subnet": "10.88.0.0/16"
         }]
       ],
       "routes": [
         { "dst": "0.0.0.0/0" }
       ]
     }
   },
   {
     "type": "portmap",
     "capabilities": {"portMappings": true}
   }
 ]
}
EOF
