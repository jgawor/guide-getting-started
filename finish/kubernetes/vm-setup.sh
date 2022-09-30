#!/bin/bash

yum install -y libassuan libgpg-error libgpg-error-devel glib2-devel glibc-devel runc conmon skopeo

mkdir $HOME/software

cd $HOME/software/
wget https://go.dev/dl/go1.18.6.linux-amd64.tar.gz
tar xvf go1.18.6.linux-amd64.tar.gz


export PATH=$HOME/software/go/bin:$PATH

rpm -i http://mirror.stream.centos.org/9-stream/CRB/x86_64/os/Packages/libassuan-devel-2.5.5-3.el9.x86_64.rpm
rpm -i http://mirror.stream.centos.org/9-stream/CRB/x86_64/os/Packages/gpgme-devel-1.15.1-6.el9.x86_64.rpm

cd $HOME/software
git clone -b release-1.24 https://github.com/cri-o/cri-o.git
cd cri-o
sed "s|-static||" -i pinns/Makefile
cp contrib/cni/11-crio-ipv4-bridge.conf /etc/cni/net.d/
make
make install
make install.systemd
systemctl daemon-reload
systemctl enable crio
systemctl start crio


cd $HOME/software
git clone https://github.com/containernetworking/plugins
cd plugins
git checkout v1.1.1
./build_linux.sh
cp bin/bridge bin/host-local bin/loopback bin/portmap /opt/cni/bin/


mkdir -p $HOME/go/src/k8s.io
cd $HOME/go/src/k8s.io
git clone -b release-1.24 https://github.com/kubernetes/kubernetes.git
cd kubernetes
make
cp 


wget -O /usr/local/bin/cfssl https://github.com/cloudflare/cfssl/releases/download/v1.6.2/cfssl_1.6.2_linux_amd64
wget -O /usr/local/bin/cfssljson https://github.com/cloudflare/cfssl/releases/download/v1.6.2/cfssljson_1.6.2_linux_amd64
chmod +x /usr/local/bin/cfssl /usr/local/bin/cfssljson

$HOME/go/src/k8s.io/kubernetes/hack/install-etcd.sh

cp $HOME/go/src/k8s.io/kubernetes/_output/bin/kubectl /usr/local/bin

systemctl enable firewalld
systemctl start firewalld
firewall-cmd --add-masquerade --permanent
