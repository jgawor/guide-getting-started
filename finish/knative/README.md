## Scale from 0 using Knative


1. Create RHEL 8.6 VM 
1. Upgrade to Kernel 5.x following https://www.osradar.com/upgrade-the-kernel-on-centos-8-rhel-8-oracle-linux-8/. This is required as Knative does not allow hostPath mounts.
1. Install Kubernetes & CRI-O
1. Deploy & configure Knative Sering using [knative-deploy.sh](./knative-deploy.sh). The `config-features` ConfigMap is required to enable setting security context properties for a Knative service. The `config-autoscaler` ConfigMap settings are optional but set to speed up scaling to zero.
1. Deploy Liberty Knative services and set up port formating using [knative-services.sh](./knative-services.sh). Wait until Liberty pods scale to zero.
1. Invoke the base Knative service using [invoke-og.sh](./invoke-og.sh].
1. Invoke the instanton Knative service using [invoke-instanton.sh](./invoke-instanon.sh).
