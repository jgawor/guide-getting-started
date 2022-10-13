## Kubernetes

### One time setup

1. Using https://fyre.ibm.com/embers get RedHat 9.0 VM (4 core or greater)
1. Login to the VM and clone this repository.
   ```
   git clone -b instanton https://github.com/jgawor/guide-getting-started.git
   ```
1. Run the `vm-setup.sh` script to install Kubernetes. By default, the `cri-o` container runtime will be used. To use the `containerd` runtime, run `vm-setup.sh containerd` instead.
   ```
   cd guide-getting-started/finish/kubernetes
   ./vm-setup.sh
   ```
1. Reboot the VM
   ```
   reboot
   ```

### Running the app

Login to the VM and start Kuberentes in one terminal window.

1. Start Kubernetes
   ```
   cd guide-getting-started/finish/kubernetes
   ./start-kube.sh &
   ```

Login to the VM in another window and run the app.

1. Check coredns pod is running.
   ```
   export KUBECONFIG=/var/run/kubernetes/admin.kubeconfig
   kubectl get pod -A
   ```
1. Deploy & configure Knative Serving.
   ```
   cd guide-getting-started/finish/knative
   ./knative-deploy.sh
   ```
1. Ensure all Knative pods are running and are ready.
   ```
   kubectl get pod -A
   ```
1. Deploy Liberty Knative services and set up port forwarding.
   ```
   cd guide-getting-started/finish/knative
   ./knative-services.sh
   ```
1. Verify that Liberty pods scale to zero.
   ```
   kubectl get pod
   ```
1. Invoke the base Knative Liberty service
   ```
   cd guide-getting-started/finish/knative
   ./invoke-og.sh
   ```
1. Invoke the instanton Knative Liberty service
   ```
   cd guide-getting-started/finish/knative
   ./invoke-instanton.sh
   ```
