## Kubernetes

1. Using https://fyre.ibm.com/embers get RedHat 9.0 VM.
1. Login to the VM and clone this repository.
   ```
   git clone -b instanton https://github.com/jgawor/guide-getting-started.git
   ```
1. Run the `vm-setup.sh` script to install Kubernetes.
   ```
   cd guide-getting-started/finish/kubernetes
   ./vm-setup.sh
   ```
1. Start Kubernetes
   ```
   cd guide-getting-started/finish/kubernetes
   ./start-kube.sh
   ```

In another window.

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
1. Ensure all Knative pods are running.
   ```
   kubectl get pod -A
   ```
1. Deploy Liberty Knative services and set up port formating.
   ```
   cd guide-getting-started/finish/knative
   ./knative-services.sh
   ```
1, Verify that Liberty pods scale to zero.
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
