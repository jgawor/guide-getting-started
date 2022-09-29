#!/bin/bash

kubectl apply -f knative-og.yaml
kubectl apply -f knative-instanton.yaml

kubectl port-forward service/kourier -n kourier-system 8080:80 &
