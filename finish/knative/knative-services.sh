#!/bin/bash

REGISTRY="${1:-docker.io/jgawor}"

cat knative-og.yaml | sed "s|image: docker.io/jgawor|image: $REGISTRY|" | kubectl apply -f -
cat knative-instanton.yaml | sed "s|image: docker.io/jgawor|image: $REGISTRY|" | kubectl apply -f -

kubectl port-forward service/kourier -n kourier-system 8080:80 &
