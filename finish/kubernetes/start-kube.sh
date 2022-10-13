#!/bin/bash -e

set -u
IP=$(ifconfig eth1 | grep 'inet '  | awk '/inet / {print $2}')
echo "Using IP: $IP"

export K8REPO=$HOME/go/src/k8s.io/kubernetes
export PATH=$HOME/software/go/bin:$K8REPO/kubernetes/third_party/etcd:$K8REPO/_output/local/bin/linux/amd64/:$K8REPO/third_party/etcd:$PATH

export FEATURE_GATES="AllAlpha=false"
export CONTAINER_RUNTIME=remote
export CGROUP_DRIVER=systemd
export ALLOW_SECURITY_CONTEXT=","
export ALLOW_PRIVILEGED=1
export DNS_SERVER_IP=$IP
export API_HOST=$IP
export API_HOST_IP=$IP
export KUBE_ENABLE_CLUSTER_DNS=true
export ENABLE_HOSTPATH_PROVISIONER=true
export KUBE_ENABLE_CLUSTER_DASHBOARD=true
export LOG_LEVEL=4

if [ -f "/var/run/crio/crio.sock" ]; then
    echo "Using CRI-O"
    export CONTAINER_RUNTIME_ENDPOINT="/var/run/crio/crio.sock"
elif [ -f "/run/containerd/containerd.sock" ]; then
    echo "Using containerd"
    export CONTAINER_RUNTIME_ENDPOINT="/run/containerd/containerd.sock"
else
    echo "Container runtime is not detected."
    exit 1
fi

# export KUBELET_RESOLV_CONF=

cd $K8REPO
./hack/local-up-cluster.sh

# rm -f /tmp/kube*
# rm -rf /var/run/kubernetes/
