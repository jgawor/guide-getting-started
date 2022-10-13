#!/bin/bash

yum install -y libassuan libgpg-error libgpg-error-devel glib2-devel glibc-devel

rpm -i http://mirror.stream.centos.org/9-stream/CRB/x86_64/os/Packages/libassuan-devel-2.5.5-3.el9.x86_64.rpm
rpm -i http://mirror.stream.centos.org/9-stream/CRB/x86_64/os/Packages/gpgme-devel-1.15.1-6.el9.x86_64.rpm

cd $HOME/software
git clone -b release-1.24 https://github.com/cri-o/cri-o.git
cd cri-o
sed "s|-static||" -i pinns/Makefile
mkdir -p /etc/cni/net.d/
cp contrib/cni/11-crio-ipv4-bridge.conf /etc/cni/net.d/
make
make install
make install.systemd
systemctl daemon-reload
systemctl enable crio
systemctl start crio
