#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

yum install -y make gcc runc conmon skopeo

systemctl enable firewalld
systemctl start firewalld
firewall-cmd --add-masquerade --permanent

mkdir -p $HOME/software

cd $HOME/software/
wget https://go.dev/dl/go1.18.6.linux-amd64.tar.gz
tar xvf go1.18.6.linux-amd64.tar.gz

export PATH=$HOME/software/go/bin:$PATH

CONTAINER_RUNTIME="${1:-crio}"

if [ "$CONTAINER_RUNTIME" = "crio" ]; then
    echo "Configuring with CRI-O"
    source $BASEDIR/crio-setup.sh
elif [ "$CONTAINER_RUNTIME" = "containerd" ]; then
    echo "Configuring with containerd"
    source $BASEDIR/containerd-setup.sh
else
    echo "Unsupported container runtime: $CONTAINER_RUNTIME"
    exit 1
fi


cd $HOME/software
git clone https://github.com/containernetworking/plugins
cd plugins
git checkout v1.1.1
./build_linux.sh
mkdir -p /opt/cni/bin/
cp bin/bridge bin/host-local bin/loopback bin/portmap bin/tuning bin/firewall /opt/cni/bin/


mkdir -p $HOME/go/src/k8s.io
cd $HOME/go/src/k8s.io
git clone -b release-1.24 https://github.com/kubernetes/kubernetes.git
cd kubernetes
make


wget -O /usr/local/bin/cfssl https://github.com/cloudflare/cfssl/releases/download/v1.6.2/cfssl_1.6.2_linux_amd64
wget -O /usr/local/bin/cfssljson https://github.com/cloudflare/cfssl/releases/download/v1.6.2/cfssljson_1.6.2_linux_amd64
chmod +x /usr/local/bin/cfssl /usr/local/bin/cfssljson

$HOME/go/src/k8s.io/kubernetes/hack/install-etcd.sh

cp $HOME/go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/local/bin

