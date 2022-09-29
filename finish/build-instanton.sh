#!/bin/bash

CONTAINER=jconf-demo-tmp
set -x

podman run --name $CONTAINER --privileged --env WLP_CHECKPOINT=applications jconf-demo


podman commit $CONTAINER jconf-demo-instanton


podman rm $CONTAINER
